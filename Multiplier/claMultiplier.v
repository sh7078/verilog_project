module claMultiplier(x,y,product);
input[15:0] x;
input[15:0] y;
output[31:0] product;

wire[15:0] xtemp [15:0];
wire[15:0] ptemp [15:0];
wire[15:0] carryTemp;

genvar i,j;
generate
for(i=0;i<16;i=i+1) 
    begin:for_loop1
        assign xtemp[i]=x & {16{y[i]}};
    end 

    assign ptemp[0]=xtemp[0];
    assign carryTemp[0]=1'b0;
    assign product[0]=ptemp[0][0];

    for(j=1;j<16;j=j+1) 
        begin:for_loop2
            claAdder add(xtemp[j],{carryTemp[j-1],ptemp[j-1][15-:15]},1'b0,ptemp[j],carryTemp[j]);
            assign product[j]=ptemp[j][0];
        end

    assign product[31:16]={carryTemp[15],ptemp[15][15-:15]};
endgenerate
endmodule