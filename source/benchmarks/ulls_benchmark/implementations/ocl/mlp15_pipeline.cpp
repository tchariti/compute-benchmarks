/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "framework/ocl/opencl.h"
#include "framework/test_case/register_test_case.h"
#include "framework/utility/timer.h"
#include <fstream>

#include "definitions/mlp15_pipeline.h"

#include <gtest/gtest.h>

static TestResult run(const MLP15PipelineArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }

    // Setup
    bool oooq = arguments.oooq;
    QueueProperties queueProperties = QueueProperties::create().setProfiling(false);
    queueProperties.setOoq(oooq);

    Opencl opencl(queueProperties);
    Timer timer;
    cl_int retVal;
    // const size_t gws = arguments.workgroupCount * arguments.workgroupSize;
    // const size_t lws = arguments.workgroupSize;

    // Create kernel
    std::ifstream file("ulls_benchmark_mlp15_pipeline.cl");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    ASSERT_CL_SUCCESS(retVal);
    ASSERT_CL_SUCCESS(clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr));
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_4844966039836895713_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0", &retVal);
    cl_kernel kernel6 = clCreateKernel(program, "softmax_gpu_bf_2709139056705541059_0", &retVal);
    cl_kernel kernel7 = clCreateKernel(program, "reorder_data_fast_b1_7733669538174986440_0", &retVal);
    ASSERT_CL_SUCCESS(retVal);

    std::vector<size_t> gws0 = {64, 1, 1};
    std::vector<size_t> lws0 = {32, 1, 1};

    std::vector<size_t> gws1234 = {512, 1, 1};
    std::vector<size_t> lws1234 = {16, 1, 1};

    std::vector<size_t> gws5 = {128, 1, 1};
    std::vector<size_t> lws5 = {16, 1, 1};

    std::vector<size_t> gws6 = {16, 1, 1};
    std::vector<size_t> lws6 = {16, 1, 1};

    std::vector<size_t> gws7 = {128, 1, 1};
    std::vector<size_t> lws7 = {32, 1, 1};

    cl_mem mem0 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 128, nullptr, &retVal);
    cl_mem mem1 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);
    cl_mem mem2 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);
    cl_mem mem3 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);
    cl_mem mem4 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 512, nullptr, &retVal);

    cl_mem weights_fc1_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 65536, nullptr, &retVal);
    cl_mem bias_fc1_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);

    cl_mem weights_fc2_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 524288, nullptr, &retVal);
    cl_mem bias_fc2_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);

    cl_mem weights_fc3_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 524288, nullptr, &retVal);
    cl_mem bias_fc3_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);

    cl_mem weights_fc4_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 524288, nullptr, &retVal);
    cl_mem bias_fc4_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 1024, nullptr, &retVal);

    cl_mem weights_fc5_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 131072, nullptr, &retVal);
    cl_mem bias_fc5_mem = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 256, nullptr, &retVal);

    cl_mem reorder0_in = mem0;
    cl_mem reorder0_out = mem1;

    cl_mem fc1_in = mem1;
    cl_mem fc1_out = mem2;

    cl_mem fc2_in = mem2;
    cl_mem fc2_out = mem3;

    cl_mem fc3_in = mem3;
    cl_mem fc3_out = mem1;

    cl_mem fc4_in = mem1;
    cl_mem fc4_out = mem2;

    cl_mem fc5_in = mem2;
    cl_mem fc5_out = mem1;

    cl_mem softmax_in = mem1;
    cl_mem softmax_out = mem2;

    cl_mem reorder1_in = mem2;
    cl_mem reorder1_out = mem4;

    // reorder
    clSetKernelArg(kernel0, 0, sizeof(reorder0_in), &reorder0_in);
    clSetKernelArg(kernel0, 1, sizeof(reorder0_out), &reorder0_out);

    // fc1
    clSetKernelArg(kernel1, 0, sizeof(fc1_in), &fc1_in);
    clSetKernelArg(kernel1, 1, sizeof(fc1_out), &fc1_out);
    clSetKernelArg(kernel1, 2, sizeof(weights_fc1_mem), &weights_fc1_mem);
    clSetKernelArg(kernel1, 3, sizeof(bias_fc1_mem), &bias_fc1_mem);

    // fc2
    clSetKernelArg(kernel2, 0, sizeof(fc2_in), &fc2_in);
    clSetKernelArg(kernel2, 1, sizeof(fc2_out), &fc2_out);
    clSetKernelArg(kernel2, 2, sizeof(weights_fc2_mem), &weights_fc2_mem);
    clSetKernelArg(kernel2, 3, sizeof(bias_fc2_mem), &bias_fc2_mem);

    // fc3
    clSetKernelArg(kernel3, 0, sizeof(fc3_in), &fc3_in);
    clSetKernelArg(kernel3, 1, sizeof(fc3_out), &fc3_out);
    clSetKernelArg(kernel3, 2, sizeof(weights_fc3_mem), &weights_fc3_mem);
    clSetKernelArg(kernel3, 3, sizeof(bias_fc3_mem), &bias_fc3_mem);

    // fc4
    clSetKernelArg(kernel4, 0, sizeof(fc4_in), &fc4_in);
    clSetKernelArg(kernel4, 1, sizeof(fc4_out), &fc4_out);
    clSetKernelArg(kernel4, 2, sizeof(weights_fc4_mem), &weights_fc4_mem);
    clSetKernelArg(kernel4, 3, sizeof(bias_fc4_mem), &bias_fc4_mem);

    // fc5
    clSetKernelArg(kernel5, 0, sizeof(fc5_in), &fc5_in);
    clSetKernelArg(kernel5, 1, sizeof(fc5_out), &fc5_out);
    clSetKernelArg(kernel5, 2, sizeof(weights_fc5_mem), &weights_fc5_mem);
    clSetKernelArg(kernel5, 3, sizeof(bias_fc5_mem), &bias_fc5_mem);

    // softmax
    clSetKernelArg(kernel6, 0, sizeof(softmax_in), &softmax_in);
    clSetKernelArg(kernel6, 1, sizeof(softmax_out), &softmax_out);

    // reorder
    clSetKernelArg(kernel7, 0, sizeof(reorder1_in), &reorder1_in);
    clSetKernelArg(kernel7, 1, sizeof(reorder1_out), &reorder1_out);


    // Warmup, kernel
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws0.data(), lws0.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws5.data(), lws5.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel6, 3, nullptr, gws6.data(), lws6.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel7, 3, nullptr, gws7.data(), lws7.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));

    if (oooq) {
        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            // Enqueue empty kernel and measure it
            timer.measureStart();
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws0.data(), lws0.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws5.data(), lws5.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel6, 3, nullptr, gws6.data(), lws6.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel7, 3, nullptr, gws7.data(), lws7.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));
            timer.measureEnd();

            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
        }
    } else {
        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            // Enqueue empty kernel and measure it
            timer.measureStart();
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws0.data(), lws0.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws1234.data(), lws1234.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws5.data(), lws5.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel6, 3, nullptr, gws6.data(), lws6.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel7, 3, nullptr, gws7.data(), lws7.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));
            timer.measureEnd();

            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
        }
    }

    // Cleanup
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel0));
    ASSERT_CL_SUCCESS(clReleaseProgram(program));
    return TestResult::Success;
}

static RegisterTestCaseImplementation<MLP15Pipeline> registerTestCase(run, Api::OpenCL);
