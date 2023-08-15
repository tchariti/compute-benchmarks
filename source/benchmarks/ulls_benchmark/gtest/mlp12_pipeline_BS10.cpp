/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/mlp12_pipeline_BS10.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<MLP12PipelineBS10> registerTestCase{};

class MLP12PipelineBS10SubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(MLP12PipelineBS10SubmissionTest, Test) {
    MLP12PipelineBS10Arguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    MLP12PipelineBS10 test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    MLP12PipelineBS10SubmissionTest,
    MLP12PipelineBS10SubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
