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

#include "definitions/bmlp15_pipeline.h"
#include "framework/ocl/opencl.h"

#include <gtest/gtest.h>

static std::vector<uint8_t> get_binary(cl_kernel kernel) {
    // Get the corresponding program object for the kernel
    //std::cout << "Bhaskar 100 \n";
    cl_program program;
    cl_int error = clGetKernelInfo(kernel, CL_KERNEL_PROGRAM, sizeof(program), &program, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_KERNEL_PROGRAM: " + std::to_string(error));
    }
   // std::cout << "Bhaskar 200 \n";
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

static ze_kernel_handle_t create_ze_kernel(const LevelZero& levelzero, cl_kernel kernel, std::string entry_point) {
    std::cout<<"Bhaskar : " << entry_point << "\n";
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
    std::ifstream file("ulls_benchmark_mlp15_pipeline_p1.cl");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr);
#if 1
    std::cout<<"Bhaskar debug 100 \n";
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_11762321333161727376_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_4545888249470468377_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_10275378013738315182_0", &retVal);
    cl_kernel kernel6 = clCreateKernel(program, "softmax_gpu_bf_5332774206223613098_0", &retVal);
    cl_kernel kernel7 = clCreateKernel(program, "reorder_data_fast_b1_9576409340358326759_0", &retVal);
std::cout<<"Bhaskar debug 200 \n";
    std::vector<ze_kernel_handle_t> kernels;
    kernels.push_back(create_ze_kernel(levelzero, kernel0, "reorder_data_fast_b1_11762321333161727376_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel1, "fully_connected_gpu_bs_f_bsv16_b1_4545888249470468377_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel2, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel3, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel4, "fully_connected_gpu_bs_f_bsv16_b1_9791167335079200504_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel5, "fully_connected_gpu_bs_f_bsv16_b1_10275378013738315182_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel6, "softmax_gpu_bf_5332774206223613098_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel7, "reorder_data_fast_b1_9576409340358326759_0"));
std::cout<<"Bhaskar debug 300 \n";    
#else
std::cout<<"Bhaskar debug 100 \n";
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_4844966039836895713_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0", &retVal);
    cl_kernel kernel6 = clCreateKernel(program, "softmax_gpu_bf_2709139056705541059_0", &retVal);
    cl_kernel kernel7 = clCreateKernel(program, "reorder_data_fast_b1_7733669538174986440_0", &retVal);
std::cout<<"Bhaskar debug 200 \n";
    std::vector<ze_kernel_handle_t> kernels;
    kernels.push_back(create_ze_kernel(levelzero, kernel0, "reorder_data_fast_b1_4844966039836895713_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel1, "fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel2, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel3, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel4, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel5, "fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel6, "softmax_gpu_bf_2709139056705541059_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel7, "reorder_data_fast_b1_7733669538174986440_0"));
std::cout<<"Bhaskar debug 300 \n";    
#endif

    return kernels;
}

static TestResult run(const BMLP15PipelineArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }
    // Setup
    LevelZero levelzero(L0::QueueProperties::create());
    Timer timer;

    std::cout<<"Bhaskar debug 2000 \n";
    // Create kernels
    auto kernel = get_kernels(levelzero);
    std::cout<<"Bhaskar debug 3000 \n";
    size_t num_kernels = kernel.size();

    ze_kernel_handle_t kernel0 = kernel[0];
    ze_kernel_handle_t kernel1 = kernel[1];
    ze_kernel_handle_t kernel2 = kernel[2];
    ze_kernel_handle_t kernel3 = kernel[3];
    ze_kernel_handle_t kernel4 = kernel[4];
    ze_kernel_handle_t kernel5 = kernel[5];
    ze_kernel_handle_t kernel6 = kernel[6];
    ze_kernel_handle_t kernel7 = kernel[7];

    ze_group_count_t gws0 = {64, 1, 1};
    std::vector<uint32_t> lws0 = {32, 1, 1};

    ze_group_count_t gws1234 = {512, 1, 1};
    std::vector<uint32_t> lws1234 = {16, 1, 1};

    ze_group_count_t gws5 = {128, 1, 1};
    std::vector<uint32_t> lws5 = {16, 1, 1};

    ze_group_count_t gws6 = {16, 1, 1};
    std::vector<uint32_t> lws6 = {16, 1, 1};

    ze_group_count_t gws7 = {128, 1, 1};
    std::vector<uint32_t> lws7 = {32, 1, 1};

    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel0, lws0[0], lws0[1], lws0[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel1, lws1234[0], lws1234[1], lws1234[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel2, lws1234[0], lws1234[1], lws1234[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel3, lws1234[0], lws1234[1], lws1234[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel4, lws1234[0], lws1234[1], lws1234[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel5, lws5[0], lws5[1], lws5[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel6, lws6[0], lws6[1], lws6[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel7, lws7[0], lws7[1], lws7[2]));

    const ze_device_mem_alloc_desc_t deviceAllocationDesc{ZE_STRUCTURE_TYPE_DEVICE_MEM_ALLOC_DESC};
    void* mem0 = nullptr;
    void* mem1 = nullptr;
    void* mem2 = nullptr;
    void* mem3 = nullptr;
    void* mem4 = nullptr;

    void* weights_fc1_mem = nullptr;
    void* bias_fc1_mem = nullptr;

    void* weights_fc2_mem = nullptr;
    void* bias_fc2_mem = nullptr;

    void* weights_fc3_mem = nullptr;
    void* bias_fc3_mem = nullptr;

    void* weights_fc4_mem = nullptr;
    void* bias_fc4_mem = nullptr;

    void* weights_fc5_mem = nullptr;
    void* bias_fc5_mem = nullptr;

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &mem0));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 512, 0, levelzero.device, &mem4));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 65536, 0, levelzero.device, &weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc1_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc2_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc3_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc4_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 131072, 0, levelzero.device, &weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc5_mem));

    void* reorder0_in = mem0;
    void* reorder0_out = mem1;

    void* fc1_in = mem1;
    void* fc1_out = mem2;

    void* fc2_in = mem2;
    void* fc2_out = mem3;

    void* fc3_in = mem3;
    void* fc3_out = mem1;

    void* fc4_in = mem1;
    void* fc4_out = mem2;

    void* fc5_in = mem2;
    void* fc5_out = mem1;

    void* softmax_in = mem1;
    void* softmax_out = mem2;

    void* reorder1_in = mem2;
    void* reorder1_out = mem4;

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel0, 0, sizeof(reorder0_in), &reorder0_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel0, 1, sizeof(reorder0_out), &reorder0_out));

    // fc1
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 0, sizeof(fc1_in), &fc1_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 1, sizeof(fc1_out), &fc1_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 2, sizeof(weights_fc1_mem), &weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel1, 3, sizeof(bias_fc1_mem), &bias_fc1_mem));

    // fc2
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 0, sizeof(fc2_in), &fc2_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 1, sizeof(fc2_out), &fc2_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 2, sizeof(weights_fc2_mem), &weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel2, 3, sizeof(bias_fc2_mem), &bias_fc2_mem));

    // fc3
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 0, sizeof(fc3_in), &fc3_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 1, sizeof(fc3_out), &fc3_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 2, sizeof(weights_fc3_mem), &weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel3, 3, sizeof(bias_fc3_mem), &bias_fc3_mem));

    // fc4
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 0, sizeof(fc4_in), &fc4_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 1, sizeof(fc4_out), &fc4_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 2, sizeof(weights_fc4_mem), &weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel4, 3, sizeof(bias_fc4_mem), &bias_fc4_mem));

    // fc5
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(fc5_in), &fc5_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(fc5_out), &fc5_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 2, sizeof(weights_fc5_mem), &weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 3, sizeof(bias_fc5_mem), &bias_fc5_mem));

    // softmax
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel6, 0, sizeof(softmax_in), &softmax_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel6, 1, sizeof(softmax_out), &softmax_out));

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel7, 0, sizeof(reorder1_in), &reorder1_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel7, 1, sizeof(reorder1_out), &reorder1_out));


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

    if (arguments.oooq) {
        ze_command_list_desc_t cmdListDesc{};
        cmdListDesc.commandQueueGroupOrdinal = levelzero.commandQueueDesc.ordinal;
        ze_command_list_handle_t cmdList;
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreate(levelzero.context, levelzero.device, &cmdListDesc, &cmdList));

        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws5, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws6, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws7, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListClose(cmdList));

        // Warmup
        ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(levelzero.commandQueue, 1, &cmdList, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(levelzero.commandQueue, std::numeric_limits<uint64_t>::max()));

        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            timer.measureStart();
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(levelzero.commandQueue, 1, &cmdList, nullptr));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(levelzero.commandQueue, std::numeric_limits<uint64_t>::max()));
            timer.measureEnd();
            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
        }
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
    } else {
        bool use_events = true;

        // Create an immediate command list
        ze_command_list_handle_t cmdList{};
        auto commandQueueDesc = L0::QueueFamiliesHelper::getPropertiesForSelectingEngine(levelzero.device, Engine::Ccs0);
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreateImmediate(levelzero.context, levelzero.device, &commandQueueDesc->desc, &cmdList));

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


        // Warmup
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws1234, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws5, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws6, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws7, event, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

        if (use_events) {
            // Benchmark
            for (auto i = 0u; i < arguments.iterations; i++) {
                timer.measureStart();
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, events[0], 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws1234, events[1], 1, &events[0]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws1234, events[2], 1, &events[1]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws1234, events[3], 1, &events[2]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws1234, events[4], 1, &events[3]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws5, events[5], 1, &events[4]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws6, events[6], 1, &events[5]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws7, event, 1, &events[6]));

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
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws1234, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws1234, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws1234, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws1234, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws5, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws6, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws7, event, 0, nullptr));

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
                timer.measureEnd();
                statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

                for (auto j = 0u; j < num_kernels; j++) {
                    ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(events[j]));
                }
            }
        }

        ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
    }

    // Cleanup
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, mem0));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, mem4));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc5_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel0));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel1));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel2));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel3));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel4));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel5));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel6));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel7));
    ASSERT_ZE_RESULT_SUCCESS(zeEventDestroy(event));
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolDestroy(eventPool));

    return TestResult::Success;
}

static RegisterTestCaseImplementation<BMLP15Pipeline> registerTestCase(run, Api::L0);
