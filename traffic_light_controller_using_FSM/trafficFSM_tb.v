module trafficFSMtb;
    reg clk;
    reg reset;
    reg A,B,C,D;

    wire red_north, yellow_north, green_north, red_east, yellow_east, green_east, red_south, yellow_south, green_south, red_west, yellow_west, green_west;
    wire [1:0] PS,NS;

    trafficFSM dut(A,B,C,D,clk,reset,red_north, yellow_north, green_north, red_east, yellow_east, green_east, red_south, yellow_south, green_south, red_west, yellow_west, green_west,PS,NS);

     // Clock generator
    always begin
        #30 clk = ~clk; // Toggle the clock every 5 time units
    end

    initial 
    begin
        $dumpfile("traffi.vcd");
        $dumpvars(0,trafficFSMtb);
        clk = 0;
        reset = 1;
        #5 reset=0;
        $monitor($time,"A=%4d, B=%4d, C=%4d, D=%4d",A,B,C,D);
        #5 A=0;B=0;C=0;D=0;
        #5 A=1;B=0;C=0;D=0;
        #40 A=1;B=0;C=1;D=0;
        #40 A=1;B=0;C=1;D=1;
        #300 $finish;
    end
endmodule