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

#include "definitions/mlp_pipeline.h"
#include "framework/ocl/opencl.h"

#include <gtest/gtest.h>

static std::vector<uint8_t> get_binary(cl_kernel kernel) {
    // Get the corresponding program object for the kernel
    cl_program program;
    cl_int error = clGetKernelInfo(kernel, CL_KERNEL_PROGRAM, sizeof(program), &program, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_KERNEL_PROGRAM: " + std::to_string(error));
    }

    // Get the size of the program binary in bytes.
    size_t binary_size = 0;
    error = clGetProgramInfo(program, CL_PROGRAM_BINARY_SIZES, sizeof(binary_size), &binary_size, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_PROGRAM_BINARY_SIZES: " + std::to_string(error));
    }

    // Binary is not available for the device.
    if (binary_size == 0)
        throw std::runtime_error("get_binary: Binary size is zero");

    // Get program binary.
    std::vector<uint8_t> binary(binary_size);
    uint8_t* binary_buffer = binary.data();
    error = clGetProgramInfo(program, CL_PROGRAM_BINARIES, binary_size, &binary_buffer, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_PROGRAM_BINARIES: " + std::to_string(error));
    }

    return binary;
}

static ze_module_handle_t ze_create_module_with_level_zero(const LevelZero& levelzero, std::vector<uint8_t> binary) {
    auto desc = ze_module_desc_t();
    desc.stype = ZE_STRUCTURE_TYPE_MODULE_DESC;
    desc.format = ZE_MODULE_FORMAT_NATIVE;
    desc.inputSize = binary.size();
    desc.pInputModule = binary.data();
    desc.pBuildFlags = "";
    desc.pConstants = nullptr;

    ze_module_handle_t ze_module;

    zeModuleCreate(levelzero.context, levelzero.device, &desc, &ze_module, nullptr);
    return ze_module;
}

ze_kernel_handle_t create_ze_kernel(const LevelZero& levelzero, cl_kernel kernel, std::string entry_point) {
    auto binary = get_binary(kernel);
    ze_module_handle_t ze_module = ze_create_module_with_level_zero(levelzero, binary);
    ze_kernel_handle_t ze_kernel;
    ze_kernel_desc_t desc = {ZE_STRUCTURE_TYPE_KERNEL_DESC , nullptr, 0, entry_point.c_str()};
    zeKernelCreate(ze_module, &desc, &ze_kernel);

    return ze_kernel;
}

static std::vector<ze_kernel_handle_t> get_kernels(const LevelZero& levelzero) {
    Opencl opencl;

    cl_int retVal;
    std::ifstream file("ulls_benchmark_mlp_pipeline.cl");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr);
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_6800974303729119626_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_224206400276664741_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16545143879977773204_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_2138333984412215348_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "softmax_gpu_bf_2769686123078786174_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "reorder_data_fast_b1_7701541509895429121_0", &retVal);

    std::vector<ze_kernel_handle_t> kernels;
    kernels.push_back(create_ze_kernel(levelzero, kernel0, "reorder_data_fast_b1_6800974303729119626_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel1, "fully_connected_gpu_bs_f_bsv16_b1_224206400276664741_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel2, "fully_connected_gpu_bs_f_bsv16_b1_16545143879977773204_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel3, "fully_connected_gpu_bs_f_bsv16_b1_2138333984412215348_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel4, "softmax_gpu_bf_2769686123078786174_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel5, "reorder_data_fast_b1_7701541509895429121_0"));

    return kernels;
}

static TestResult run(const MLPPipelineArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }
    if (arguments.oooq) {
        return TestResult::FilteredOut;
    }

    // Setup
    LevelZero levelzero(L0::QueueProperties::create().disable());
    Timer timer;

    // Create kernel
    auto spirvModule = FileHelper::loadBinaryFile("ulls_benchmark_empty_kernel.spv");
    if (spirvModule.size() == 0) {
        return TestResult::KernelNotFound;
    }
    auto kernel = get_kernels(levelzero);
    ze_kernel_handle_t kernel0 = kernel[0];
    ze_kernel_handle_t kernel1 = kernel[1];
    ze_kernel_handle_t kernel2 = kernel[2];
    ze_kernel_handle_t kernel3 = kernel[3];
    ze_kernel_handle_t kernel4 = kernel[4];
    ze_kernel_handle_t kernel5 = kernel[5];

    ze_group_count_t gws05 = {32, 1, 1};
    std::vector<uint32_t> lws05 = {32, 1, 1};

    ze_group_count_t gws12 = {128, 1, 1};
    std::vector<uint32_t> lws12 = {16, 1, 1};

    ze_group_count_t gws3 = {32, 1, 1};
    std::vector<uint32_t> lws3 = {16, 1, 1};

    ze_group_count_t gws4 = {8, 1, 1};
    std::vector<uint32_t> lws4 = {8, 1, 1};

    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel0, lws05[0], lws05[1], lws05[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel1, lws12[0], lws12[1], lws12[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel2, lws12[0], lws12[1], lws12[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel3, lws3[0], lws3[1], lws3[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel4, lws4[0], lws4[1], lws4[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel5, lws05[0], lws05[1], lws05[2]));

    const ze_device_mem_alloc_desc_t deviceAllocationDesc{ZE_STRUCTURE_TYPE_DEVICE_MEM_ALLOC_DESC};
    void* mem1 = nullptr;
    void* mem2 = nullptr;
    void* mem3 = nullptr;
    void* mem4 = nullptr;
    void* mem5 = nullptr;
    void* mem6 = nullptr;
    void* mem7 = nullptr;
    void* mem8 = nullptr;
    void* mem9 = nullptr;
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 64, 0, levelzero.device, &mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 8192, 0, levelzero.device, &mem4));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &mem5));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &mem6));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 64, 0, levelzero.device, &mem7));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 8192, 0, levelzero.device, &mem8));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 64, 0, levelzero.device, &mem9));

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel0, 0, sizeof(mem1), &mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel0, 1, sizeof(mem2), &mem2));

    // fc1
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 0, sizeof(mem2), &mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 1, sizeof(mem3), &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 2, sizeof(mem4), &mem4));

    // fc2
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 0, sizeof(mem3), &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 1, sizeof(mem6), &mem6));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 2, sizeof(mem5), &mem5));

    // fc3
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 0, sizeof(mem6), &mem6));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 1, sizeof(mem7), &mem7));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 2, sizeof(mem8), &mem8));

    // softmax
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 0, sizeof(mem7), &mem7));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 1, sizeof(mem9), &mem9));

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(mem9), &mem9));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(mem1), &mem1));


    // Create event
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
    auto commandQueueDesc = L0::QueueFamiliesHelper::getPropertiesForSelectingEngine(levelzero.device, Engine::Ccs0);
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreateImmediate(levelzero.context, levelzero.device, &commandQueueDesc->desc, &cmdList));

    // Warmup
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws05, nullptr, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12, nullptr, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12, nullptr, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws3, nullptr, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws4, nullptr, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws05, event, 0, nullptr));
    ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
    ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

    // Benchmark
    for (auto i = 0u; i < arguments.iterations; i++) {
        timer.measureStart();
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws05, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws3, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws4, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws05, event, 0, nullptr));

        ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
        timer.measureEnd();
        statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());

        ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));
    }

    // Cleanup
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel0));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel1));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel2));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel3));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel4));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel5));
    ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
    ASSERT_ZE_RESULT_SUCCESS(zeEventDestroy(event));
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolDestroy(eventPool));

    return TestResult::Success;
}

static RegisterTestCaseImplementation<MLPPipeline> registerTestCase(run, Api::L0);
