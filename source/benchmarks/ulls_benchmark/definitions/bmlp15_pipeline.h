/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct BMLP15PipelineArguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    BMLP15PipelineArguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct BMLP15Pipeline : TestCase<BMLP15PipelineArguments> {
    using TestCase<BMLP15PipelineArguments>::TestCase;

    std::string getTestCaseName() const override {
        return "BMLP15Pipeline";
    }

    std::string getHelp() const override {
        return "enqueues MLP pipeline.";
    }
};
