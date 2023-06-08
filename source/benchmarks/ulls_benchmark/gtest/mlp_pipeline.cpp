/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/mlp_pipeline.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<MLPPipeline> registerTestCase{};

class MLPPipelineSubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(MLPPipelineSubmissionTest, Test) {
    MLPPipelineArguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    MLPPipeline test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    MLPPipelineSubmissionTest,
    MLPPipelineSubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
