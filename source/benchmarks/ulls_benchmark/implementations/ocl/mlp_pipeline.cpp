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

#include "definitions/mlp_pipeline.h"

#include <gtest/gtest.h>

static TestResult run(const MLPPipelineArguments &arguments, Statistics &statistics) {
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
    std::ifstream file("ulls_benchmark_mlp_pipeline.cl");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    ASSERT_CL_SUCCESS(retVal);
    ASSERT_CL_SUCCESS(clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr));
    cl_kernel kernel0 = clCreateKernel(program, "reorder_data_fast_b1_6800974303729119626_0", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_224206400276664741_0", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_16545143879977773204_0", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "fully_connected_gpu_bs_f_bsv16_b1_2138333984412215348_0", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "softmax_gpu_bf_2769686123078786174_0", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "reorder_data_fast_b1_7701541509895429121_0", &retVal);
    ASSERT_CL_SUCCESS(retVal);

    std::vector<size_t> gws05 = {32, 1, 1};
    std::vector<size_t> lws05 = {32, 1, 1};

    std::vector<size_t> gws12 = {128, 1, 1};
    std::vector<size_t> lws12 = {16, 1, 1};

    std::vector<size_t> gws3 = {32, 1, 1};
    std::vector<size_t> lws3 = {16, 1, 1};

    std::vector<size_t> gws4 = {8, 1, 1};
    std::vector<size_t> lws4 = {8, 1, 1};

    cl_mem mem1 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 128, nullptr, &retVal);
    cl_mem mem2 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 64, nullptr, &retVal);

    cl_mem mem3 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 256, nullptr, &retVal);
    cl_mem mem4 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 8192, nullptr, &retVal);
    cl_mem mem5 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 32768, nullptr, &retVal);
    cl_mem mem6 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 256, nullptr, &retVal);
    cl_mem mem7 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 64, nullptr, &retVal);
    cl_mem mem8 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 8192, nullptr, &retVal);

    cl_mem mem9 = clCreateBuffer(opencl.context, CL_MEM_READ_WRITE, 64, nullptr, &retVal);

    // reorder
    clSetKernelArg(kernel0, 0, sizeof(mem1), &mem1);
    clSetKernelArg(kernel0, 1, sizeof(mem2), &mem2);

    // fc1
    clSetKernelArg(kernel1, 0, sizeof(mem2), &mem2);
    clSetKernelArg(kernel1, 1, sizeof(mem3), &mem3);
    clSetKernelArg(kernel1, 2, sizeof(mem4), &mem4);

    // fc2
    clSetKernelArg(kernel2, 0, sizeof(mem3), &mem3);
    clSetKernelArg(kernel2, 1, sizeof(mem6), &mem6);
    clSetKernelArg(kernel2, 2, sizeof(mem5), &mem5);

    // fc3
    clSetKernelArg(kernel3, 0, sizeof(mem6), &mem6);
    clSetKernelArg(kernel3, 1, sizeof(mem7), &mem7);
    clSetKernelArg(kernel3, 2, sizeof(mem8), &mem8);

    // softmax
    clSetKernelArg(kernel4, 0, sizeof(mem7), &mem7);
    clSetKernelArg(kernel4, 1, sizeof(mem9), &mem9);

    // reorder
    clSetKernelArg(kernel5, 0, sizeof(mem9), &mem9);
    clSetKernelArg(kernel5, 1, sizeof(mem1), &mem1);


    // Warmup, kernel
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws3.data(), lws3.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws4.data(), lws4.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));

    if (oooq) {
        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            // Enqueue empty kernel and measure it
            timer.measureStart();
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws3.data(), lws3.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws4.data(), lws4.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueBarrierWithWaitList(opencl.commandQueue, 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));
            timer.measureEnd();

            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
        }
    } else {
        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            // Enqueue empty kernel and measure it
            timer.measureStart();
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 3, nullptr, gws12.data(), lws12.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 3, nullptr, gws3.data(), lws3.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 3, nullptr, gws4.data(), lws4.data(), 0, nullptr, nullptr));
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 3, nullptr, gws05.data(), lws05.data(), 0, nullptr, nullptr));
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

static RegisterTestCaseImplementation<MLPPipeline> registerTestCase(run, Api::OpenCL);
