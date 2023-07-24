/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "definitions/bmlp15_pipeline.h"

#include "framework/test_case/register_test_case.h"
#include "framework/utility/common_gtest_args.h"

#include <gtest/gtest.h>

[[maybe_unused]] static const inline RegisterTestCase<BMLP15Pipeline> registerTestCase{};

class BMLP15PipelineSubmissionTest : public ::testing::TestWithParam<std::tuple<Api, bool>> {
};

TEST_P(BMLP15PipelineSubmissionTest, Test) {
    BMLP15PipelineArguments args;
    args.api = std::get<0>(GetParam());
    args.oooq = std::get<1>(GetParam());

    BMLP15Pipeline test;
    test.run(args);
}

INSTANTIATE_TEST_SUITE_P(
    BMLP15PipelineSubmissionTest,
    BMLP15PipelineSubmissionTest,
    ::testing::Combine(
        ::CommonGtestArgs::allApis(),
        ::testing::Values(true, false)));
