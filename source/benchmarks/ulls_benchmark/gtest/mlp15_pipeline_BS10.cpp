/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/mlp15_pipeline_BS10.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<MLP15PipelineBS10> registerTestCase{};

class MLP15PipelineBS10SubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(MLP15PipelineBS10SubmissionTest, Test) {
    MLP15PipelineBS10Arguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    MLP15PipelineBS10 test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    MLP15PipelineBS10SubmissionTest,
    MLP15PipelineBS10SubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
