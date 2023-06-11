`timescale 1ps/1ps
module TwoStagePipeline_TB;

  // Testbench inputs
  reg clk;
  reg reset;
  reg [31:0] instruction;
  reg [31:0] operand1;
  reg [31:0] operand2;

  // Testbench outputs
  wire [31:0] result;

  // Instantiate the DUT
  TwoStagePipeline dut (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .operand1(operand1),
    .operand2(operand2),
    .result(result)
  );

  // Clock generator
  always begin
    #5 clk = ~clk; // Toggle the clock every 5 time units
  end

  // Initialize inputs
  initial begin
    $dumpfile("example.vcd");
    $dumpvars(0,TwoStagePipeline_TB);
    clk = 0;
    reset = 1;
    instruction = 0;
    operand1 = 0;
    operand2 = 0;
    #2 reset = 0; // Release reset after 10 time units

    // Test scenario 1: Addition
    #5 instruction = 4'b0000; operand1 = 5; operand2 = 3; // Set operand2
    #40 $display("Result (Addition): %d", result);

    // Test scenario 2: Subtraction
    #15 instruction = 4'b0001; operand1 = 10; operand2 = 4; // Set operand2
    #40 $display("Result (Subtraction): %d", result);

    // Add more test scenarios here as needed

   $finish; // End simulation
  end

endmodule
