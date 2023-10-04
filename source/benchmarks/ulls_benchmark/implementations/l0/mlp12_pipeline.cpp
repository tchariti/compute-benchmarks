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

#include "definitions/mlp12_pipeline.h"
#include "framework/ocl/opencl.h"

#include <gtest/gtest.h>
#include <x86intrin.h>

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

static ze_kernel_handle_t create_ze_kernel(const LevelZero& levelzero, cl_kernel kernel, std::string entry_point) {
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
    std::ifstream file("/home/tchariti/compute-benchmarks/source/benchmarks/ulls_benchmark/kernels/copyable_sources/MLP_10-12_sync_cldumps/clDNN_program_1_bucket_0_part_0_15017634162181700438.cl");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();

    //Build from source files
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    std::cout<<"clCreateProgramWithSource retVal=" << retVal << std::endl;
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr);

    //Build from binary files
    /* cl_int binStatus;
    cl_program program = clCreateProgramWithBinary(opencl.context, 1, &opencl.device, &sourceLength, (const unsigned char **) &data_ptr, &binStatus, &retVal);
    std::cout<<" clCreateProgramWithBinary, binStatus, retVal =  " << binStatus << "," << retVal << std::endl;
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr); // Must be called even when loading binary */

#if 1
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_17182053592672782609_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_4189689361718010219_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel6 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel7 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel8 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0", &retVal);
    cl_kernel kernel9 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_10198823769218063516_0", &retVal);
    cl_kernel kernel10 = clCreateKernel(program, "softmax_gpu_bf_4033561128309031624_0", &retVal);
    cl_kernel kernel11 = clCreateKernel(program, "reorder_data_fast_b1_1859976072953354345_0", &retVal);

    std::vector<ze_kernel_handle_t> kernels;
    kernels.push_back(create_ze_kernel(levelzero, kernel0, "reorder_data_fast_b1_17182053592672782609_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel1, "fully_connected_gpu_bs_f_bsv16_b1_4189689361718010219_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel2, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel3, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel4, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel5, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel6, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel7, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel8, "fully_connected_gpu_bs_f_bsv16_b1_9995861220820203849_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel9, "fully_connected_gpu_bs_f_bsv16_b1_10198823769218063516_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel10, "softmax_gpu_bf_4033561128309031624_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel11, "reorder_data_fast_b1_1859976072953354345_0"));   
#else

    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_4844966039836895713_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0", &retVal);
    cl_kernel kernel6 = clCreateKernel(program, "softmax_gpu_bf_2709139056705541059_0", &retVal);
    cl_kernel kernel7 = clCreateKernel(program, "reorder_data_fast_b1_7733669538174986440_0", &retVal);

    std::vector<ze_kernel_handle_t> kernels;
    kernels.push_back(create_ze_kernel(levelzero, kernel0, "reorder_data_fast_b1_4844966039836895713_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel1, "fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel2, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel3, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel4, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel5, "fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel6, "softmax_gpu_bf_2709139056705541059_0"));
    kernels.push_back(create_ze_kernel(levelzero, kernel7, "reorder_data_fast_b1_7733669538174986440_0"));
#endif

    return kernels;
}

static TestResult run(const MLP12PipelineArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }
    // Setup
    LevelZero levelzero(L0::QueueProperties::create());
    Timer timer;

    // Create kernels
    auto kernel = get_kernels(levelzero);
    size_t num_kernels = kernel.size();

    ze_kernel_handle_t kernel0 = kernel[0];
    ze_kernel_handle_t kernel1 = kernel[1];
    ze_kernel_handle_t kernel2 = kernel[2];
    ze_kernel_handle_t kernel3 = kernel[3];
    ze_kernel_handle_t kernel4 = kernel[4];
    ze_kernel_handle_t kernel5 = kernel[5];
    ze_kernel_handle_t kernel6 = kernel[6];
    ze_kernel_handle_t kernel7 = kernel[7];
    ze_kernel_handle_t kernel8 = kernel[8];
    ze_kernel_handle_t kernel9 = kernel[9];
    ze_kernel_handle_t kernel10 = kernel[10];
    ze_kernel_handle_t kernel11 = kernel[11];

    ze_group_count_t gws0 = {32, 1, 1};
    std::vector<uint32_t> lws0 = {32, 1, 1};

    ze_group_count_t gws12345678 = {128, 1, 1};
    std::vector<uint32_t> lws12345678 = {16, 1, 1}; 

    ze_group_count_t gws9 = {64, 1, 1};
    std::vector<uint32_t> lws9 = {16, 1, 1};

    ze_group_count_t gws10 = {8, 1, 1};
    std::vector<uint32_t> lws10 = {8, 1, 1};

    ze_group_count_t gws11 = {64, 1, 1};
    std::vector<uint32_t> lws11 = {32, 1, 1}; 

    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel0, lws0[0], lws0[1], lws0[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel1, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel2, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel3, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel4, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel5, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel6, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel7, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel8, lws12345678[0], lws12345678[1], lws12345678[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel9, lws9[0], lws9[1], lws9[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel10, lws10[0], lws10[1], lws10[2]));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernel11, lws11[0], lws11[1], lws11[2]));

    //Allocating memory to device, alt to host (L3 cache?)
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

    void* weights_fc6_mem = nullptr;
    void* bias_fc6_mem = nullptr;

    void* weights_fc7_mem = nullptr;
    void* bias_fc7_mem = nullptr;

    void* weights_fc8_mem = nullptr;
    void* bias_fc8_mem = nullptr;

    void* weights_fc9_mem = nullptr;
    void* bias_fc9_mem = nullptr;

    //Assign buffer size (0 mem and 1 mem)
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 64, 0, levelzero.device, &mem0));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &mem4));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 8192, 0, levelzero.device, &weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc1_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc2_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc3_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc4_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc5_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc6_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc6_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc7_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc7_mem));
    
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 32768, 0, levelzero.device, &weights_fc8_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc8_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 16384, 0, levelzero.device, &weights_fc9_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &bias_fc9_mem));

    void* reorder0_in = mem0;
    void* reorder0_out = mem1;

    void* fc1_in = mem1;
    void* fc1_out = mem3;

    void* fc2_in = mem3;
    void* fc2_out = mem4;

    void* fc3_in = mem4;
    void* fc3_out = mem3;

    void* fc4_in = mem3;
    void* fc4_out = mem4;

    void* fc5_in = mem4;
    void* fc5_out = mem3;

    void* fc6_in = mem3;
    void* fc6_out = mem4;

    void* fc7_in = mem4;
    void* fc7_out = mem3;
    
    void* fc8_in = mem3;
    void* fc8_out = mem4;

    void* fc9_in = mem4;
    void* fc9_out = mem1;

    void* softmax_in = mem1;
    void* softmax_out = mem2;

    void* reorder1_in = mem2;
    void* reorder1_out = mem4; //final result buffer

    //Kernel Arguments are set here

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

    // fc6
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(fc6_in), &fc6_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(fc6_out), &fc6_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 2, sizeof(weights_fc6_mem), &weights_fc6_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 3, sizeof(bias_fc6_mem), &bias_fc6_mem));

    // fc7
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(fc7_in), &fc7_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(fc7_out), &fc7_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 2, sizeof(weights_fc7_mem), &weights_fc7_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 3, sizeof(bias_fc7_mem), &bias_fc7_mem));

    // fc8
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(fc8_in), &fc8_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(fc8_out), &fc8_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 2, sizeof(weights_fc8_mem), &weights_fc8_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 3, sizeof(bias_fc8_mem), &bias_fc8_mem));

    // fc9
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 0, sizeof(fc9_in), &fc9_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 1, sizeof(fc9_out), &fc9_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 2, sizeof(weights_fc9_mem), &weights_fc9_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel5, 3, sizeof(bias_fc9_mem), &bias_fc9_mem));

    // softmax
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel6, 0, sizeof(softmax_in), &softmax_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel6, 1, sizeof(softmax_out), &softmax_out));

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel7, 0, sizeof(reorder1_in), &reorder1_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernel7, 1, sizeof(reorder1_out), &reorder1_out));

    //The buffer for the last layer contains the model output. Change allocation type from usm device to 
    //usm host to save output to host accesible memory. Otherwise make explicit copy of usm device out buffer (in this case "reorder1_out").
    //Not clear which method is faster. In openvino input and output are saved in streams. 

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
        //Since MLP model has linear structure barrier is used after each command. Barrier guarantees that the previous kernel is 
        //finished before the next one is executed. Here we are building the schedule for the gpu
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel8, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel9, &gws9, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel10, &gws10, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel11, &gws11, nullptr, 0, nullptr));
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
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel8, &gws12345678, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel9, &gws9, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel10, &gws10, nullptr, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws11, event, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

        if (use_events) {
            // Benchmark
            for (auto i = 0u; i < arguments.iterations; i++) {
                timer.measureStart();
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel0, &gws0, events[0], 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12345678, events[1], 1, &events[0]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12345678, events[2], 1, &events[1]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws12345678, events[3], 1, &events[2]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws12345678, events[4], 1, &events[3]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws12345678, events[5], 1, &events[4]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws12345678, events[6], 1, &events[5]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws12345678, events[7], 1, &events[6]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel8, &gws12345678, events[8], 1, &events[7]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel9, &gws9, events[9], 1, &events[8]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel10, &gws10, events[10], 1, &events[9]));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel11, &gws11, event, 1, &events[10]));

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
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel1, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel2, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel3, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel4, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel5, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel6, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel7, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel8, &gws12345678, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel9, &gws9, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel10, &gws10, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernel11, &gws11, event, 0, nullptr));

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
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc6_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc6_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc7_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc7_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc8_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc8_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, weights_fc9_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, bias_fc9_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel0));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel1));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel2));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel3));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel4));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel5));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel6));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel7));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel8));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel9));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel10));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernel11));
    ASSERT_ZE_RESULT_SUCCESS(zeEventDestroy(event));
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolDestroy(eventPool));

    return TestResult::Success;
}

static RegisterTestCaseImplementation<MLP12Pipeline> registerTestCase(run, Api::L0);
