/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLP09PipelineBS10Arguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLP09PipelineBS10Arguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLP09PipelineBS10 : TestCase<MLP09PipelineBS10Arguments> {
    using TestCase<MLP09PipelineBS10Arguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLP09PipelineBS10";
    }

    std::string getHelp() const override {
        return "enqueues MLP09 pipeline batch size 10.";
    }
};
