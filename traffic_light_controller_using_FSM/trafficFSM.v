module trafficFSM(
    input A,B,C,D,clk,reset,
    output reg red_north,
    output reg yellow_north,
    output reg green_north,
    output reg red_east,
    output reg yellow_east,
    output reg green_east,
    output reg red_south,
    output reg yellow_south,
    output reg green_south,
    output reg red_west,
    output reg yellow_west,
    output reg green_west,
    output reg [1:0] PS,NS);
    parameter S0=0, S1=1, S2=2, S3=3;
    // output reg [1:0] PS,NS;
    always @(posedge clk or posedge reset) begin
        if(reset) PS<=S0;
        else PS<=NS;
    end
    always @(posedge clk) begin
        PS=NS;
        case (PS)
            S0: begin
                if (B == 1) NS<=  S1;
                else if (C==1) NS<=  S2;
                else if (D==1) NS<=  S3;
                // else if (A==1) NS= S0;
                else NS<=  S1;
                red_north<=0;
                yellow_north<=0;
                green_north<=1;
                red_east<=1;
                yellow_east<=0;
                green_east<=0;
                red_south<=1;
                yellow_south<=0;
                green_south<=0;
                red_west<=1;
                yellow_west<=0;
                green_west<=0;

                red_north<= #50 0;
                yellow_north<=#50 1;
                green_north<=#50 0;
                red_east<=#50 1;
                yellow_east<=#50 0;
                green_east<=#50 0;
                red_south<=#50 1;
                yellow_south<=#50 0;
                green_south<=#50 0;
                red_west<=#50 1;
                yellow_west<=#50 0;
                green_west<=#50 0;
                
            end
            S1: begin
                if (C == 1) NS<=  S2;
                else if (D==1) NS<=  S3;
                else if (A==1) NS<=  S0;
                // else if (B==1) NS= S1;
                else NS<=  S2;
                red_north<=1;
                yellow_north<=0;
                green_north<=0;
                red_east<=0;
                yellow_east<=0;
                green_east<=1;
                red_south<=1;
                yellow_south<=0;
                green_south<=0;
                red_west<=1;
                yellow_west<=0;
                green_west<=0;

                red_north<=#50 1;
                yellow_north<=#50 0;
                green_north<=#50 0;
                red_east<=#50 0;
                yellow_east<=#50 1;
                green_east<=#50 0;
                red_south<=#50 1;
                yellow_south<=#50 0;
                green_south<=#50 0;
                red_west<=#50 1;
                yellow_west<=#50 0;
                green_west<=#50 0;
                
            end
            S2: begin
                if (D == 1) NS<=  S3;
                else if (A==1) NS<=  S0;
                else if (B==1) NS<=  S1;
                // else if (C==1) NS= S2;
                else NS<=  S3;
                red_north<=1;
                yellow_north<=0;
                green_north<=0;
                red_east<=1;
                yellow_east<=0;
                green_east<=0;
                red_south<=0;
                yellow_south<=0;
                green_south<=1;
                red_west<=1;
                yellow_west<=0;
                green_west<=0;

                red_north<=#50 1;
                yellow_north<=#50 0;
                green_north<=#50 0;
                red_east<=#50 1;
                yellow_east<=#50 0;
                green_east<=#50 0;
                red_south<=#50 0;
                yellow_south<=#50 1;
                green_south<=#50 0;
                red_west<=#50 1;
                yellow_west<=#50 0;
                green_west<=#50 0;
                
            end
            S3: begin
                if (A == 1) NS<=  S0;
                else if (B==1) NS<=  S1;
                else if (C==1) NS<=  S2;
                // else if (D==1) NS= S3; 
                else NS<=  S0;
                red_north<=1;
                yellow_north<=0;
                green_north<=0;
                red_east<=1;
                yellow_east<=0;
                green_east<=0;
                red_south<=1;
                yellow_south<=0;
                green_south<=0;
                red_west<=0;
                yellow_west<=0;
                green_west<=1;

                red_north<=#50 1;
                yellow_north<=#50 0;
                green_north<=#50 0;
                red_east<=#50 1;
                yellow_east<=#50 0;
                green_east<=#50 0;
                red_south<=#50 1;
                yellow_south<=#50 0;
                green_south<=#50 0;
                red_west<=#50 0;
                yellow_west<=#50 1;
                green_west<=#50 0;
                
            end
            default: begin
                if (A == 1) NS<=S0;
                else if (B==1) NS<=S1;
                else if (C==1) NS<=S2;
                else if (D==1) NS<=S3;
                else NS<=S0;
                red_north<=1;
                yellow_north<=0;
                green_north<=0;
                red_east<=1;
                yellow_east<=0;
                green_east<=0;
                red_south<=1;
                yellow_south<=0;
                green_south<=0;
                red_west<=1;
                yellow_west<=0;
                green_west<=0;
                
            end
        endcase    
    end    
    
endmodule


