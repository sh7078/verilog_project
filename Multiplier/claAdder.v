module claAdder(in1,in2,cin,sum,cout);
input[15:0] in1;
input[15:0] in2;
input cin;
output[15:0] sum;
output cout;

wire[15:0] gen;
wire[15:0] prop;
wire[16:0] ctemp;

assign gen=in1 & in2;
assign prop= in1 ^ in2;
assign ctemp[0]=cin;

genvar i,j;
generate
    for(i=0;i<16;i=i+1) 
        begin:carry_gen
            assign ctemp[i+1]=gen[i] | (prop[i] & ctemp[i]);
        end

    assign cout=ctemp[16];

    for(j=0;j<16;j=j+1) 
        begin:sum_withou_carry
            assign sum[j]=in1[j]^in2[j]^ctemp[j];
        end
endgenerate
endmodule




