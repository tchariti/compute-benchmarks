/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "framework/ocl/opencl.h"
#include "framework/test_case/register_test_case.h"
#include "framework/utility/timer.h"

#include "definitions/empty_kernel.h"

#include <gtest/gtest.h>

static TestResult run(const EmptyKernelArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }

    // Setup
    Opencl opencl;
    Timer timer;
    cl_int retVal;
    const size_t gws = arguments.workgroupCount * arguments.workgroupSize;
    const size_t lws = arguments.workgroupSize;

    // Create kernel
    const char *source = "__kernel void empty() {}";
    const auto sourceLength = strlen(source);
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &source, &sourceLength, &retVal);
    ASSERT_CL_SUCCESS(retVal);
    ASSERT_CL_SUCCESS(clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr));
    cl_kernel kernel0 = clCreateKernel(program, "empty", &retVal);
    cl_kernel kernel1 = clCreateKernel(program, "empty", &retVal);
    cl_kernel kernel2 = clCreateKernel(program, "empty", &retVal);
    cl_kernel kernel3 = clCreateKernel(program, "empty", &retVal);
    cl_kernel kernel4 = clCreateKernel(program, "empty", &retVal);
    cl_kernel kernel5 = clCreateKernel(program, "empty", &retVal);
    ASSERT_CL_SUCCESS(retVal);

    // Warmup, kernel
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));

    // Benchmark
    for (auto i = 0u; i < arguments.iterations; i++) {
        // Enqueue empty kernel and measure it
        timer.measureStart();
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel0, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel1, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel2, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel3, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel4, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernel5, 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));
        timer.measureEnd();

        statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
    }

    // Cleanup
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel0));
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel1));
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel2));
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel3));
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel4));
    ASSERT_CL_SUCCESS(clReleaseKernel(kernel5));
    ASSERT_CL_SUCCESS(clReleaseProgram(program));
    return TestResult::Success;
}

static RegisterTestCaseImplementation<EmptyKernel> registerTestCase(run, Api::OpenCL);
