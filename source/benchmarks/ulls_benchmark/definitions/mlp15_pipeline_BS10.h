/*
 * Copyright (C) 2022 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#pragma once

#include "framework/argument/basic_argument.h"
#include "framework/test_case/test_case.h"

struct MLP15PipelineBS10Arguments : TestCaseArgumentContainer {
    BooleanArgument oooq;

    MLP15PipelineBS10Arguments()
        : oooq(*this, "oooq", "OOOQ enabled or disabled") {}
};

struct MLP15PipelineBS10 : TestCase<MLP15PipelineBS10Arguments> {
    using TestCase<MLP15PipelineBS10Arguments>::TestCase;

    std::string getTestCaseName() const override {
        return "MLP15PipelineBS10";
    }

    std::string getHelp() const override {
        return "enqueues MLP pipeline.";
    }
};
