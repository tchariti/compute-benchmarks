/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "framework/l0/levelzero.h"
#include "framework/test_case/register_test_case.h"
#include "framework/utility/file_helper.h"
#include "framework/utility/timer.h"

#include "definitions/empty_kernel_immediate.h"

#include <gtest/gtest.h>

static TestResult run(const EmptyKernelImmediateArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }

    // Setup
    LevelZero levelzero(QueueProperties::create().disable());
    Timer timer;

    // Create kernel
    auto spirvModule = FileHelper::loadBinaryFile("ulls_benchmark_empty_kernel.spv");
    if (spirvModule.size() == 0) {
        return TestResult::KernelNotFound;
    }
    ze_module_handle_t module;
    size_t num_kernels = 8;
    std::vector<ze_kernel_handle_t> kernels(num_kernels);
    ze_module_desc_t moduleDesc{ZE_STRUCTURE_TYPE_MODULE_DESC};
    moduleDesc.format = ZE_MODULE_FORMAT_IL_SPIRV;
    moduleDesc.pInputModule = reinterpret_cast<const uint8_t *>(spirvModule.data());
    moduleDesc.inputSize = spirvModule.size();
    ASSERT_ZE_RESULT_SUCCESS(zeModuleCreate(levelzero.context, levelzero.device, &moduleDesc, &module, nullptr));

    uint32_t groupSizeX = static_cast<uint32_t>(arguments.workgroupSize);
    uint32_t groupSizeY = 1u;
    uint32_t groupSizeZ = 1u;

    ze_group_count_t groupCounts;
    groupCounts.groupCountX = static_cast<uint32_t>(arguments.workgroupCount);
    groupCounts.groupCountY = 1u;
    groupCounts.groupCountZ = 1u;

    for (size_t i = 0; i < num_kernels; i++) {
        ze_kernel_desc_t kernelDesc{ZE_STRUCTURE_TYPE_KERNEL_DESC};
        kernelDesc.pKernelName = "empty";
        ASSERT_ZE_RESULT_SUCCESS(zeKernelCreate(module, &kernelDesc, &kernels[i]));
        ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernels[i], groupSizeX, groupSizeY, groupSizeZ));
    }

    // Create out event
    ze_event_pool_handle_t eventPool{};
    ze_event_handle_t event{};
    ze_event_pool_desc_t eventPoolDesc{ZE_STRUCTURE_TYPE_EVENT_POOL_DESC};
    eventPoolDesc.flags = ZE_EVENT_POOL_FLAG_HOST_VISIBLE;
    eventPoolDesc.count = 1;
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolCreate(levelzero.context, &eventPoolDesc, 1, &levelzero.device, &eventPool));
    ze_event_desc_t eventDesc{ZE_STRUCTURE_TYPE_EVENT_DESC};
    eventDesc.index = 0;
    eventDesc.signal = ZE_EVENT_SCOPE_FLAG_DEVICE;
    ASSERT_ZE_RESULT_SUCCESS(zeEventCreate(eventPool, &eventDesc, &event));

    // Create an immediate command list
    ze_command_list_handle_t cmdList{};
    auto commandQueueDesc = QueueFamiliesHelper::getPropertiesForSelectingEngine(levelzero.device, Engine::Ccs0);
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreateImmediate(levelzero.context, levelzero.device, &commandQueueDesc->desc, &cmdList));

    // Warmup
    for (size_t i = 0; i < num_kernels - 1; i++) {
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[i], &groupCounts, nullptr, 0, nullptr));
    }

    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[num_kernels - 1], &groupCounts, event, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
    ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));


    bool use_events = false;
    if (use_events) {
        ze_event_pool_handle_t eventPoolDevice{};
        std::vector<ze_event_handle_t> events(num_kernels);
        ze_event_pool_desc_t eventPoolDeviceDesc{ZE_STRUCTURE_TYPE_EVENT_POOL_DESC};
        eventPoolDeviceDesc.count = num_kernels;
        ASSERT_ZE_RESULT_SUCCESS(zeEventPoolCreate(levelzero.context, &eventPoolDeviceDesc, 1, &levelzero.device, &eventPoolDevice));
        for (size_t i = 0; i < num_kernels; i++) {
            ze_event_desc_t eventDeviceDesc{ZE_STRUCTURE_TYPE_EVENT_DESC};
            eventDeviceDesc.index = i;
            eventDeviceDesc.signal = ZE_EVENT_SCOPE_FLAG_DEVICE;
            ASSERT_ZE_RESULT_SUCCESS(zeEventCreate(eventPoolDevice, &eventDeviceDesc, &events[i]));
        }


        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            timer.measureStart();
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[0], &groupCounts, events[0], 0, nullptr));
            for (size_t j = 1; j < num_kernels - 1; j++) {
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[j], &groupCounts, events[j], 1, &events[j-1]));
            }
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[num_kernels - 1], &groupCounts, event, 1, &events[num_kernels - 2]));

            ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
            timer.measureEnd();
            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
            ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

            for (auto j = 0u; j < num_kernels; j++) {
                ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(events[j]));
            }
        }
    } else {
        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            timer.measureStart();
            for (size_t j = 0; j < num_kernels - 1; j++) {
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[j], &groupCounts, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
            }
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[num_kernels - 1], &groupCounts, event, 0, nullptr));

            ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
            timer.measureEnd();
            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
            ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));
        }
    }

    // Cleanup
    ASSERT_ZE_RESULT_SUCCESS(zeModuleDestroy(module));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
    ASSERT_ZE_RESULT_SUCCESS(zeEventDestroy(event));
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolDestroy(eventPool));

    return TestResult::Success;
}

static RegisterTestCaseImplementation<EmptyKernelImmediate> registerTestCase(run, Api::L0);
