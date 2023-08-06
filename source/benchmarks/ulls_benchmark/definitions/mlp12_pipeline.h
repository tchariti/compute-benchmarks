/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLP12PipelineArguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLP12PipelineArguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLP12Pipeline : TestCase<MLP12PipelineArguments> {
    using TestCase<MLP12PipelineArguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLP12Pipeline";
    }

    std::string getHelp() const override {
        return "enqueues MLP12 pipeline.";
    }
};
