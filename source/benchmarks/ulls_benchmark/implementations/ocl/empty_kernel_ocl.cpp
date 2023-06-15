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

    size_t num_kernels = 8;
    std::vector<cl_kernel> kernels;
    for (size_t i = 0; i < num_kernels; i++) {
        kernels.push_back(clCreateKernel(program, "empty", &retVal));
        ASSERT_CL_SUCCESS(retVal);
    }

    // Warmup, kernel
    for (size_t i = 0; i < num_kernels; i++) {
        ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernels[i], 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
    }
    ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));

    // Benchmark
    for (auto i = 0u; i < arguments.iterations; i++) {
        // Enqueue empty kernel and measure it
        timer.measureStart();
        for (size_t i = 0; i < num_kernels; i++) {
            ASSERT_CL_SUCCESS(clEnqueueNDRangeKernel(opencl.commandQueue, kernels[i], 1, nullptr, &gws, &lws, 0, nullptr, nullptr));
        }

        ASSERT_CL_SUCCESS(clFinish(opencl.commandQueue));
        timer.measureEnd();

        statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
    }

    // Cleanup
    for (size_t i = 0; i < num_kernels; i++) {
        ASSERT_CL_SUCCESS(clReleaseKernel(kernels[i]));
    }
    ASSERT_CL_SUCCESS(clReleaseProgram(program));
    return TestResult::Success;
}

static RegisterTestCaseImplementation<EmptyKernel> registerTestCase(run, Api::OpenCL);
