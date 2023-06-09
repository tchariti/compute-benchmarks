/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/mlp15_pipeline.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<MLP15Pipeline> registerTestCase{};

class MLP15PipelineSubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(MLP15PipelineSubmissionTest, Test) {
    MLP15PipelineArguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    MLP15Pipeline test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    MLP15PipelineSubmissionTest,
    MLP15PipelineSubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
