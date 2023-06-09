/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLP15PipelineArguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLP15PipelineArguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLP15Pipeline : TestCase<MLP15PipelineArguments> {
    using TestCase<MLP15PipelineArguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLP15Pipeline";
    }

    std::string getHelp() const override {
        return "enqueues MLP pipeline.";
    }
};
