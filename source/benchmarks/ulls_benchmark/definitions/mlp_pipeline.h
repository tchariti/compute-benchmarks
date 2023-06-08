/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLPPipelineArguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLPPipelineArguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLPPipeline : TestCase<MLPPipelineArguments> {
    using TestCase<MLPPipelineArguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLPPipeline";
    }

    std::string getHelp() const override {
        return "enqueues MLP pipeline.";
    }
};
