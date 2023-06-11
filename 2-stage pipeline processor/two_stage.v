module TwoStagePipeline(
  input wire clk,
  input wire reset,
  input wire [31:0] instruction,
  input wire [31:0] operand1,
  input wire [31:0] operand2,
  output wire [31:0] result
);

  // Pipeline registers
  reg [31:0] pc;
  reg [31:0] instruction_fetch_reg;
  reg [31:0] operand1_fetch_reg;
  reg [31:0] operand2_fetch_reg;
  reg [31:0] instruction_decode_reg;
  reg [31:0] operand1_decode_reg;
  reg [31:0] operand2_decode_reg;
  reg [31:0] result_execute_reg;
  reg [31:0] result_writeback_reg;

  // Control signals
  reg stall;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset all pipeline registers and control signals
      pc <= 0;
      instruction_fetch_reg <= 0;
      operand1_fetch_reg <= 0;
      operand2_fetch_reg <= 0;
    end
    else begin
      pc <= pc + 1;
      instruction_fetch_reg <= instruction;
      operand1_fetch_reg <= operand1;
      operand2_fetch_reg <= operand2;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset all pipeline registers and control signals
      instruction_decode_reg <= 0;
      operand1_decode_reg <= 0;
      operand2_decode_reg <= 0;
      result_execute_reg <= 0;
      result_writeback_reg <= 0;
    end
    else begin
      instruction_decode_reg <= instruction_fetch_reg;
      operand1_decode_reg <= operand1_fetch_reg;
      operand2_decode_reg <= operand2_fetch_reg;    
      case (instruction_decode_reg[31:28])
          4'b0000: result_execute_reg <= operand1_decode_reg + operand2_decode_reg; // Addition
          4'b0001: result_execute_reg <= operand1_decode_reg - operand2_decode_reg; // Subtraction
          default: result_execute_reg <= 0; // No operation
      endcase
      result_writeback_reg <= result_execute_reg;
    end
  end     
    
  // Output assignment
  assign result = result_writeback_reg;

endmodule
