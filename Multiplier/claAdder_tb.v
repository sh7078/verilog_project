module claAdder_tb;
reg[15:0] in1,in2;
reg cin;
wire cout;
wire[15:0] sum;

claAdder cla1(in1,in2,cin,sum,cout);

initial 
  begin
    in1=16'd0;
    in2=16'd0;
    cin=1'b0;
  end

initial 
  begin
    $dumpfile("claAdder.vcd");
    $dumpvars(0,claAdder_tb);
    $monitor ($time, "in1=%d, in2=%d, cin=%b, sum=%d, cout=%b", in1,in2,cin,sum,cout); 
    #5 in1=16'd10; 
    #5 in1=16'd20; 
    #5 in2=16'd10;
    #5 in2=16'd20;
    #5 in2=16'd0;
    #15 in1=16'hFFFF; in2=16'hFFFF;
    #15 in1=16'h7FFF; in2=16'hFFFF;
    #15 in1=16'hBFFF; in2=16'hFFFF;
 end 
endmodule