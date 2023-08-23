# verilog_project

- Use Verilog/System Verilog for design
- Always write a Testbench for a design
- Testbench should be self-checking test bench
- Testbench should use task for sending input data to the DUT

## Verilog Designs with Testbenches
1. [Traffic Light Controller using FSM](https://github.com/sh7078/verilog_project/tree/main/traffic_light_controller_using_FSM)
    
    In this project, I consider 4 streets namely A(north), B(east), C(south), and D(west). Whenever there is a vehicle present in any of the streets (A, B, C, D) its value becomes equal to 1 otherwise it will go like A -> B -> C -> D. At every street Green light will be enabled for 50 seconds, and 10 seconds for yellow line.
2. [2-Stage pipeline processor](https://github.com/sh7078/verilog_project/tree/main/2-stage%20pipeline%20processor)
    
    The processor consists of two stages: Stage 1 and Stage 2. In each stage, the input data is stored in a register. On each positive edge of the clock signal (posedge clk), the data is transferred from one stage to the next. The reset signal (reset) is used to initialize the registers to 0 when it is asserted.

    The TwoStagePipeline module is the top-level module. It includes the input and output ports necessary for the pipeline stages.

    The FetchStage represents the fetch stage of the pipeline. It contains fetch registers to hold the fetched instruction, operand1, and operand2. The instruction_decode output is directly assigned with the value of instruction_fetch_reg. The output ports instruction_fetch, operand1_fetch and operand2_fetch are assigned with the corresponding fetch registers.

    The ExecuteStage represents the execute stage of the pipeline. It contains execute registers to hold the result of the execution. The result_execute output is assigned with the value of result_execute_reg, computed based on the fetched operands. The result_writeback output is assigned with the value of result_execute_reg. The inputs and outputs of this module are connected to the appropriate signals from the TwoStagePipeline module.

3. [MIPS 32](https://github.com/sh7078/verilog_project/tree/main/MIPS32)

   In this project, I created an MIPS32(Microprocessor without Interlocked Pipeline Stage) 32-bit processor. It is a family of Reduced Instruction Set Computer (RISC) Instruction Set Architectures (ISA).
   #### It includes a 5-stage process:

   -[Instruction Fetch](#1)

   -[Instruction Decode](#2)

   -[Execution Stage](#3)

   -[Memory Stage](#4)

   -[Write back Stage](#5)


   Also created testBench to calculate the factorial of the number 7.
   Its sketch diagram is given as:
   
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/MIPS_Architecture_%28Pipelined%29.svg/1280px-MIPS_Architecture_%28Pipelined%29.svg.png" width="full" height="400">
