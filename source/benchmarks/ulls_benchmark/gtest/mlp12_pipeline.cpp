/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/mlp12_pipeline.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<MLP12Pipeline> registerTestCase{};

class MLP12PipelineSubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(MLP12PipelineSubmissionTest, Test) {
    MLP12PipelineArguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    MLP12Pipeline test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    MLP12PipelineSubmissionTest,
    MLP12PipelineSubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
