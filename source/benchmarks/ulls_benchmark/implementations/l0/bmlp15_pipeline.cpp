/*
 * Copyright (C) 2022-2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 */

#include "framework/l0/levelzero.h"
#include "framework/test_case/register_test_case.h"
#include "framework/utility/file_helper.h"
#include "framework/utility/timer.h"

#include "definitions/bmlp15_pipeline.h"
#include "framework/ocl/opencl.h"

#include <gtest/gtest.h>
#include <x86intrin.h>

static std::vector<uint8_t> get_binary(cl_kernel kernel) {
    // Get the corresponding program object for the kernel
    cl_program program;
    cl_int error = clGetKernelInfo(kernel, CL_KERNEL_PROGRAM, sizeof(program), &program, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_KERNEL_PROGRAM: " + std::to_string(error));
    }

    // Get the size of the program binary in bytes.
    size_t binary_size = 0;
    error = clGetProgramInfo(program, CL_PROGRAM_BINARY_SIZES, sizeof(binary_size), &binary_size, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_PROGRAM_BINARY_SIZES: " + std::to_string(error));
    }

    // Binary is not available for the device.
    if (binary_size == 0)
        throw std::runtime_error("get_binary: Binary size is zero");

    // Get program binary.
    std::vector<uint8_t> binary(binary_size);
    uint8_t* binary_buffer = binary.data();
    error = clGetProgramInfo(program, CL_PROGRAM_BINARIES, binary_size, &binary_buffer, nullptr);
    if (error) {
        throw std::runtime_error("Failed to retrieve CL_PROGRAM_BINARIES: " + std::to_string(error));
    }

    return binary;
}

static ze_module_handle_t ze_create_module_with_level_zero(const LevelZero& levelzero, std::vector<uint8_t> binary) {
    auto desc = ze_module_desc_t();
    desc.stype = ZE_STRUCTURE_TYPE_MODULE_DESC;
    desc.format = ZE_MODULE_FORMAT_NATIVE;
    desc.inputSize = binary.size();
    desc.pInputModule = binary.data();
    desc.pBuildFlags = "";
    desc.pConstants = nullptr;

    ze_module_handle_t ze_module;

    zeModuleCreate(levelzero.context, levelzero.device, &desc, &ze_module, nullptr);
    return ze_module;
}

static ze_kernel_handle_t create_ze_kernel(const LevelZero& levelzero, cl_kernel kernel, std::string entry_point) {
    auto binary = get_binary(kernel);
    ze_module_handle_t ze_module = ze_create_module_with_level_zero(levelzero, binary);
    ze_kernel_handle_t ze_kernel;
    ze_kernel_desc_t desc = {ZE_STRUCTURE_TYPE_KERNEL_DESC , nullptr, 0, entry_point.c_str()};
    ze_result_t err = zeKernelCreate(ze_module, &desc, &ze_kernel);
    
    if (err!=ZE_RESULT_SUCCESS) {
        std::cout<<"Kernel creation failed with error:"<<err <<"for :" << entry_point.c_str();
    }

    return ze_kernel;
}

static std::vector<ze_kernel_handle_t> get_kernels_generic(const LevelZero& levelzero, std::string sourcep, std::vector<std::string> kNames) {
    Opencl opencl;

    cl_int retVal;
    std::ifstream file(sourcep.c_str());
    //std::cout<<" Source name: "<< sourcep.c_str() << "\n";
    //std::ifstream file("/home/tchariti/ericsson/compute-benchmarks/source/benchmarks/ulls_benchmark/kernels/copyable_sources/ulls_benchmark_prog1_bmlp15_pipeline_sync_adls.bin");
    std::stringstream buffer;
    buffer << file.rdbuf();
    const std::string source = buffer.str();
    auto data_ptr = source.data();
    const auto sourceLength = source.length();

#if 1
    //Build from source files
    cl_program program = clCreateProgramWithSource(opencl.context, 1, &data_ptr, &sourceLength, &retVal);
    //if (retVal )  {
    //    std::cout<<"clCreateProgramWithSource retVal=" << retVal << std::endl;
    //}
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr);
#else     
    //Build from binary files
    cl_int binStatus;
    cl_program program = clCreateProgramWithBinary(opencl.context, 1, &opencl.device, &sourceLength, (const unsigned char **) &data_ptr, &binStatus, &retVal);
    std::cout<<" clCreateProgramWithBinary, binStatus, retVal =  " << binStatus << "," << retVal << std::endl;
    clBuildProgram(program, 1, &opencl.device, nullptr, nullptr, nullptr); // Must be called even when loading binary
#endif

    std::vector<cl_kernel> cl_kernels;
    std::vector<ze_kernel_handle_t> l0_kernels;

    for(unsigned int i =0; i<kNames.size();i++) {
        //std::cout<<"Kernal name:" << kNames[i].c_str() <<":"<< i << "\n";
        cl_kernels.push_back(clCreateKernel(program, kNames[i].c_str(), &retVal)); 
        if(retVal != CL_SUCCESS) {
            std::cout<<"clKernel create failed with Error " << retVal <<"\n";
        }
    }

    for(unsigned int i =0; i<kNames.size();i++) {
        l0_kernels.push_back(create_ze_kernel(levelzero, cl_kernels[i], kNames[i].c_str()));
    }
    
    return l0_kernels;
}

static TestResult allocAndSetMemForKernels(const LevelZero& levelzero, std::vector<ze_kernel_handle_t> kernels, std::vector<void *>& dev_memory_ptrs){

    const ze_device_mem_alloc_desc_t deviceAllocationDesc{ZE_STRUCTURE_TYPE_DEVICE_MEM_ALLOC_DESC};
    void* mem0 = nullptr;
    void* mem1 = nullptr;
    void* mem2 = nullptr;
    void* mem3 = nullptr;
    void* mem4 = nullptr;

    void* weights_fc1_mem = nullptr;
    void* bias_fc1_mem = nullptr;

    void* weights_fc2_mem = nullptr;
    void* bias_fc2_mem = nullptr;

    void* weights_fc3_mem = nullptr;
    void* bias_fc3_mem = nullptr;

    void* weights_fc4_mem = nullptr;
    void* bias_fc4_mem = nullptr;

    void* weights_fc5_mem = nullptr;
    void* bias_fc5_mem = nullptr;

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 128, 0, levelzero.device, &mem0));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem1));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem2));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &mem3));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 512, 0, levelzero.device, &mem4));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 65536, 0, levelzero.device, &weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc1_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc2_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc3_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 524288, 0, levelzero.device, &weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 1024, 0, levelzero.device, &bias_fc4_mem));

    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 131072, 0, levelzero.device, &weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeMemAllocDevice(levelzero.context, &deviceAllocationDesc, 256, 0, levelzero.device, &bias_fc5_mem));

    dev_memory_ptrs.push_back(mem0);
    dev_memory_ptrs.push_back(mem1);
    dev_memory_ptrs.push_back(mem2);
    dev_memory_ptrs.push_back(mem3);
    dev_memory_ptrs.push_back(mem4);

    dev_memory_ptrs.push_back(weights_fc1_mem);
    dev_memory_ptrs.push_back(weights_fc2_mem);
    dev_memory_ptrs.push_back(weights_fc3_mem);
    dev_memory_ptrs.push_back(weights_fc4_mem);
    dev_memory_ptrs.push_back(weights_fc5_mem);

    dev_memory_ptrs.push_back(bias_fc1_mem);
    dev_memory_ptrs.push_back(bias_fc2_mem);
    dev_memory_ptrs.push_back(bias_fc3_mem);
    dev_memory_ptrs.push_back(bias_fc4_mem);
    dev_memory_ptrs.push_back(bias_fc5_mem);

    void* reorder0_in = mem0;
    void* reorder0_out = mem1;

    void* fc1_in = mem1;
    void* fc1_out = mem2;

    void* fc2_in = mem2;
    void* fc2_out = mem3;

    void* fc3_in = mem3;
    void* fc3_out = mem1;

    void* fc4_in = mem1;
    void* fc4_out = mem2;

    void* fc5_in = mem2;
    void* fc5_out = mem1;

    void* softmax_in = mem1;
    void* softmax_out = mem2;

    void* reorder1_in = mem2;
    void* reorder1_out = mem4;

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[0], 0, sizeof(reorder0_in), &reorder0_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[0], 1, sizeof(reorder0_out), &reorder0_out));

    // fc1
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[1], 0, sizeof(fc1_in), &fc1_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[1], 1, sizeof(fc1_out), &fc1_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[1], 2, sizeof(weights_fc1_mem), &weights_fc1_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[1], 3, sizeof(bias_fc1_mem), &bias_fc1_mem));

    // fc2
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[2], 0, sizeof(fc2_in), &fc2_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[2], 1, sizeof(fc2_out), &fc2_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[2], 2, sizeof(weights_fc2_mem), &weights_fc2_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[2], 3, sizeof(bias_fc2_mem), &bias_fc2_mem));

    // fc3
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[3], 0, sizeof(fc3_in), &fc3_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[3], 1, sizeof(fc3_out), &fc3_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[3], 2, sizeof(weights_fc3_mem), &weights_fc3_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[3], 3, sizeof(bias_fc3_mem), &bias_fc3_mem));

    // fc4
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[4], 0, sizeof(fc4_in), &fc4_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[4], 1, sizeof(fc4_out), &fc4_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[4], 2, sizeof(weights_fc4_mem), &weights_fc4_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[4], 3, sizeof(bias_fc4_mem), &bias_fc4_mem));

    // fc5
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[5], 0, sizeof(fc5_in), &fc5_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[5], 1, sizeof(fc5_out), &fc5_out));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[5], 2, sizeof(weights_fc5_mem), &weights_fc5_mem));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[5], 3, sizeof(bias_fc5_mem), &bias_fc5_mem));

    // softmax
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[6], 0, sizeof(softmax_in), &softmax_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[6], 1, sizeof(softmax_out), &softmax_out));

    // reorder
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[7], 0, sizeof(reorder1_in), &reorder1_in));
    ASSERT_ZE_RESULT_SUCCESS(zeKernelSetArgumentValue(kernels[7], 1, sizeof(reorder1_out), &reorder1_out));
    return TestResult::Success;
}

static TestResult run(const BMLP15PipelineArguments &arguments, Statistics &statistics) {
    MeasurementFields typeSelector(MeasurementUnit::Microseconds, MeasurementType::Cpu);

    if (isNoopRun()) {
        statistics.pushUnitAndType(typeSelector.getUnit(), typeSelector.getType());
        return TestResult::Nooped;
    }
    // Setup
    LevelZero levelzero(L0::QueueProperties::create());
    Timer timer;

    // knames
    std::vector<std::string> kNames;  

    kNames.push_back("reorder_data_fast_b1_4844966039836895713_0");
    kNames.push_back("fully_connected_gpu_bs_f_bsv16_b1_16141029346741138833_0");
    kNames.push_back("fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0");
    kNames.push_back("fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0");
    kNames.push_back("fully_connected_gpu_bs_f_bsv16_b1_8263732740786614254_0");
    kNames.push_back("fully_connected_gpu_bs_f_bsv16_b1_16124995141712052246_0");
    kNames.push_back("softmax_gpu_bf_2709139056705541059_0");
    kNames.push_back("reorder_data_fast_b1_7733669538174986440_0");

    // Create kernels
    auto kernels = get_kernels_generic(levelzero, "ulls_benchmark_mlp15_pipeline.cl", kNames);
    auto kernels_model2 = get_kernels_generic(levelzero, "ulls_benchmark_mlp15_pipeline.cl", kNames);

    size_t num_kernels = kernels.size();
    std::vector<ze_group_count_t> gws;
    gws.push_back({64, 1, 1});
    gws.push_back({512, 1, 1});
    gws.push_back({512, 1, 1});
    gws.push_back({512, 1, 1});
    gws.push_back({512, 1, 1});
    gws.push_back({128, 1, 1});
    gws.push_back({16, 1, 1});
    gws.push_back({128, 1, 1});

    std::vector<std::vector<uint32_t>> lws;
    lws.push_back({32, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({16, 1, 1});
    lws.push_back({32, 1, 1});

    for(size_t i=0; i<kernels.size();i++) {
        ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernels[i], lws[i][0], lws[i][1], lws[i][2]));
    }

    for(size_t i=0; i<kernels_model2.size();i++) {
        ASSERT_ZE_RESULT_SUCCESS(zeKernelSetGroupSize(kernels_model2[i], lws[i][0], lws[i][1], lws[i][2]));
    }

    std::vector<void *> dev_memory_ptrs;

    allocAndSetMemForKernels(levelzero, kernels, dev_memory_ptrs);
    allocAndSetMemForKernels(levelzero, kernels_model2, dev_memory_ptrs);

    // Create event
    ze_event_pool_handle_t eventPool{};
    ze_event_handle_t event{};
    ze_event_pool_desc_t eventPoolDesc{ZE_STRUCTURE_TYPE_EVENT_POOL_DESC};
    eventPoolDesc.flags = ZE_EVENT_POOL_FLAG_HOST_VISIBLE;
    eventPoolDesc.count = 1;
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolCreate(levelzero.context, &eventPoolDesc, 1, &levelzero.device, &eventPool));
    ze_event_desc_t eventDesc{ZE_STRUCTURE_TYPE_EVENT_DESC};
    eventDesc.index = 0;
    eventDesc.signal = ZE_EVENT_SCOPE_FLAG_DEVICE;
    ASSERT_ZE_RESULT_SUCCESS(zeEventCreate(eventPool, &eventDesc, &event));

{
    // Discover all command queue groups
    uint32_t cmdqueueGroupCount = 0;
    zeDeviceGetCommandQueueGroupProperties(levelzero.device, &cmdqueueGroupCount, nullptr);

    ze_command_queue_group_properties_t* cmdqueueGroupProperties = (ze_command_queue_group_properties_t*)
        malloc(cmdqueueGroupCount * sizeof(ze_command_queue_group_properties_t));
    for( uint32_t i = 0; i < cmdqueueGroupCount; ++i ) {
        cmdqueueGroupProperties[ i ].stype = ZE_STRUCTURE_TYPE_COMMAND_QUEUE_GROUP_PROPERTIES;
        cmdqueueGroupProperties[ i ].pNext = nullptr;
    }
    zeDeviceGetCommandQueueGroupProperties(levelzero.device, &cmdqueueGroupCount, cmdqueueGroupProperties);


    // Find a command queue type that support compute

   // for( uint32_t i = 0; i < cmdqueueGroupCount; ++i ) {
    //    std::cout<<"Bhaskar DEBUG 100:: Command queue group::"<<i<<"::Queue Count::"<<cmdqueueGroupProperties[i].numQueues << std::endl;
   // }

}


    if (arguments.oooq) {
#if 1
        ze_command_queue_desc_t commandQueueDesc{ZE_STRUCTURE_TYPE_COMMAND_QUEUE_DESC};
        std::vector<ze_command_queue_handle_t> queues(2);
        std::vector<ze_command_list_handle_t> cmdLists(2);
        
        {
            commandQueueDesc.index = 0;
            queues[0] = levelzero.createQueue(levelzero.device, commandQueueDesc);
            //commandQueueDesc.index = 1;
            //queues[1] = levelzero.createQueue(levelzero.device, commandQueueDesc);

            ze_command_list_desc_t cmdListDesc{};
            cmdListDesc.commandQueueGroupOrdinal = commandQueueDesc.ordinal;

            ze_command_list_handle_t cmdListTemp;
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreate(levelzero.context, levelzero.device, &cmdListDesc, &cmdListTemp));
            cmdLists[0] = cmdListTemp;
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreate(levelzero.context, levelzero.device, &cmdListDesc, &cmdListTemp));
            cmdLists[1] = cmdListTemp; 
            for(size_t i=0; i<kernels.size();i++) {
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdLists[0], kernels[i], &gws[i], nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdLists[0], nullptr, 0, nullptr));
            }            
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListClose(cmdLists[0]));

            for(size_t i=0; i<kernels_model2.size();i++) {
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdLists[1], kernels_model2[i], &gws[i], nullptr, 0, nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdLists[1], nullptr, 0, nullptr));
            }
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListClose(cmdLists[1]));

            // Warmup
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(queues[0], 1, &cmdLists[0], nullptr));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(queues[0], std::numeric_limits<uint64_t>::max()));

            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(queues[0], 1, &cmdLists[1], nullptr));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(queues[0], std::numeric_limits<uint64_t>::max()));

            // Benchmark
            for (auto i = 0u; i < arguments.iterations; i++) {
                timer.measureStart();
                ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(queues[0], 1, &cmdLists[0], nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(queues[0], 1, &cmdLists[1], nullptr));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(queues[0], std::numeric_limits<uint64_t>::max()));
                ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(queues[0], std::numeric_limits<uint64_t>::max()));
                timer.measureEnd();
                statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
            }
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdLists[0]));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdLists[1]));
        }
#else
        ze_command_list_desc_t cmdListDesc{};
        cmdListDesc.commandQueueGroupOrdinal = levelzero.commandQueueDesc.ordinal;
        ze_command_list_handle_t cmdList;
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreate(levelzero.context, levelzero.device, &cmdListDesc, &cmdList));

        for(size_t i=0; i<kernels.size();i++) {
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[i], &gws[i], nullptr, 0, nullptr));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
        }

        ASSERT_ZE_RESULT_SUCCESS(zeCommandListClose(cmdList));

        // Warmup
        ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(levelzero.commandQueue, 1, &cmdList, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(levelzero.commandQueue, std::numeric_limits<uint64_t>::max()));

        // Benchmark
        for (auto i = 0u; i < arguments.iterations; i++) {
            timer.measureStart();
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueExecuteCommandLists(levelzero.commandQueue, 1, &cmdList, nullptr));
            ASSERT_ZE_RESULT_SUCCESS(zeCommandQueueSynchronize(levelzero.commandQueue, std::numeric_limits<uint64_t>::max()));
            timer.measureEnd();
            statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());
        }
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
#endif
    } else {
        bool use_events = true;

        // Create an immediate command list
        ze_command_list_handle_t cmdList{};
        auto commandQueueDesc = L0::QueueFamiliesHelper::getPropertiesForSelectingEngine(levelzero.device, Engine::Ccs0);
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListCreateImmediate(levelzero.context, levelzero.device, &commandQueueDesc->desc, &cmdList));

        ze_event_pool_handle_t eventPoolDevice{};
        std::vector<ze_event_handle_t> events(num_kernels);
        ze_event_pool_desc_t eventPoolDeviceDesc{ZE_STRUCTURE_TYPE_EVENT_POOL_DESC};
        eventPoolDeviceDesc.count = num_kernels;
        ASSERT_ZE_RESULT_SUCCESS(zeEventPoolCreate(levelzero.context, &eventPoolDeviceDesc, 1, &levelzero.device, &eventPoolDevice));
        for (size_t i = 0; i < num_kernels; i++) {
            ze_event_desc_t eventDeviceDesc{ZE_STRUCTURE_TYPE_EVENT_DESC};
            eventDeviceDesc.index = i;
            eventDeviceDesc.signal = ZE_EVENT_SCOPE_FLAG_DEVICE;
            ASSERT_ZE_RESULT_SUCCESS(zeEventCreate(eventPoolDevice, &eventDeviceDesc, &events[i]));
        }


        // Warmup
        for(size_t i=0; i<kernels.size()-1;i++) {
            ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[i], &gws[i], nullptr, 0, nullptr));
        }
        ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[kernels.size()-1], &gws[kernels.size()-1], event, 0, nullptr));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
        ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

        if (use_events) {
            // Benchmark
            for (auto i = 0u; i < arguments.iterations; i++) {
                timer.measureStart();
                for(size_t i=0; i<kernels.size()-1;i++) {
                    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[i], &gws[i], events[i], 0, nullptr));
                }
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[kernels.size()-1], &gws[kernels.size()-1], event, 1, &events[kernels.size()-2]));

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
                timer.measureEnd();
                statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

                for (auto j = 0u; j < num_kernels; j++) {
                    ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(events[j]));
                }
            }
        } else {
            // Benchmark
            for (auto i = 0u; i < arguments.iterations; i++) {
                timer.measureStart();
                for(size_t i=0; i<kernels.size()-1;i++) {
                    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[i], &gws[i], nullptr, 0, nullptr));
                    ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendBarrier(cmdList, nullptr, 0, nullptr));
                }
                ASSERT_ZE_RESULT_SUCCESS(zeCommandListAppendLaunchKernel(cmdList, kernels[kernels.size()-1], &gws[kernels.size()-1], event, 0, nullptr));

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostSynchronize(event, std::numeric_limits<uint64_t>::max()));
                timer.measureEnd();
                statistics.pushValue(timer.get(), typeSelector.getUnit(), typeSelector.getType());

                ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(event));

                for (auto j = 0u; j < num_kernels; j++) {
                    ASSERT_ZE_RESULT_SUCCESS(zeEventHostReset(events[j]));
                }
            }
        }

        ASSERT_ZE_RESULT_SUCCESS(zeCommandListDestroy(cmdList));
    }

    // Cleanup
    for (auto k = 0u; k < dev_memory_ptrs.size() ; k++) {
        ASSERT_ZE_RESULT_SUCCESS(zeMemFree(levelzero.context, dev_memory_ptrs[k]));
    }

    for(size_t i=0; i<kernels.size()-1;i++) {
        ASSERT_ZE_RESULT_SUCCESS(zeKernelDestroy(kernels[i]));
    }
    ASSERT_ZE_RESULT_SUCCESS(zeEventDestroy(event));
    ASSERT_ZE_RESULT_SUCCESS(zeEventPoolDestroy(eventPool));

    return TestResult::Success;
}

static RegisterTestCaseImplementation<BMLP15Pipeline> registerTestCase(run, Api::L0);
