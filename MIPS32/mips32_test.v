module test_mips32;
reg clk1, clk2;
integer k;
  
pipe_MIPS32 mips(.clk1(clk1), .clk2(clk2));
initial 
  begin
    clk1= 0; clk2 = 0;
    repeat(50)
      begin
        #5 clk1 = 1; #5 clk1 = 0; 
        #5 clk2 = 1; #5 clk2 = 0;
      end
  end
  
initial
  begin
    for(k=0; k<31; k=k+1) 
      mips.Reg[k] = k;

    mips.Mem[200] = 32'h00000007;
    mips.Mem[0]= 32'h280a00c8;
    mips.Mem[1]= 32'h28020001; 
    mips.Mem[2]= 32'h0e94a000;
    mips.Mem[3]= 32'h21430000;
    mips.Mem[4]= 32'h0e94a000;
    mips.Mem[5]= 32'h14431000;
    mips.Mem[6]= 32'h2c630001;
    mips.Mem[7]= 32'h0e94a000;
    mips.Mem[8]= 32'h3460fffc;
    mips.Mem[9]= 32'h2542fffe;
    mips.Mem[10]=32'hfc000000;
    
    
    mips.PC = 0;
    mips.HALTED = 0;
    mips.TAKEN_BRANCH = 0;
    
    #2000 $display ("Mem[200]=%2d, Mem[198] =%6d", mips.Mem[200], mips.Mem[198]);

  end

initial 
  begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test_mips32);
    $monitor ("R2: %4d", mips.Reg[2]);
    //$monitor ("R3: %4d", mips.Reg[3]);
      //$monitor ("R10: %4d", mips.Reg[10]);
      
    #3000 $finish;
  end
endmodule