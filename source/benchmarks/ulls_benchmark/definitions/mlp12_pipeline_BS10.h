/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLP12PipelineBS10Arguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLP12PipelineBS10Arguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLP12PipelineBS10 : TestCase<MLP12PipelineBS10Arguments> {
    using TestCase<MLP12PipelineBS10Arguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLP12PipelineBS10";
    }

    std::string getHelp() const override {
        return "enqueues MLP12 pipeline batch size 10.";
    }
};
