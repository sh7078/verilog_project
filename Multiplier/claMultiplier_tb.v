module claMultiplier_tb;
reg[15:0] x;
reg[15:0] y;
wire[31:0] product;
integer i;


claMultiplier mul1(x,y,product);

initial 
    begin
        for(i=0;i<30;i=i+1) 
            begin:loop
                #5 x=x+1; y=y+1;
            end
    end

initial 
    begin
        $dumpfile("claMultiplier.vcd");
        $dumpvars(0,claMultiplier_tb);
        $monitor($time,"x=%d,y=%d,product=%d", x,y,product);
        #5 x=16'h7FFF; y=16'h007F;
        #5 x=16'h8000; y=16'h00F0;
        #5 x=16'h8FF0; y=16'h00F0;
        #5 x=16'h7FF0; y=16'h00F7;
        #5 x=16'h7FF0; y=16'h00F7;
    end
endmodule
