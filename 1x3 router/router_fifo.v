module router_fifo(input clock,
    resetn,
    write_enb,
    soft_reset,
    read_enb,
    lfd_state,
    input [7:0] data_in,
    output empty,full,
    output reg [7:0] data_out);
    reg [8:0] mem [0:15];
    reg [4:0] wr_ptr,rd_ptr;
    reg [6:0] fifo_counter;
    reg lfd_tmp;
    integer i;
    // Logic for lfd_state
    always@(posedge clock)
        begin
            if(!resetn)
                lfd_tmp <= 0;
            else
                lfd_tmp <= lfd_state;
        end
    // Logic for read and write pointer
    always@(posedge clock)
        begin
            if(!resetn)
                begin
                    wr_ptr <= 0;
                    rd_ptr <= 0;
                end
            else if(soft_reset)
                begin
                    wr_ptr <= 0;
                    rd_ptr <= 0;
                end
            else
                begin
                    if(!full && write_enb)
                        wr_ptr <= wr_ptr + 1'b1;
                    if(!empty && read_enb)
                        rd_ptr <= rd_ptr + 1'b1;
                end
        end
    // Logic for FIFO counter
    always@(posedge clock)
        begin
            if(!resetn)
                fifo_counter <= 0;
            else if(soft_reset)
                fifo_counter <= 0;
            else if(read_enb && !empty)
                begin
                    if(mem[rd_ptr[3:0]][8] == 1'b1)
                        fifo_counter <= mem[rd_ptr[3:0]][7:2] + 1'b1;
                    else if(fifo_counter)
                        fifo_counter <= fifo_counter - 1'b1;
                end
        end
    // Logic for read operation
    always@(posedge clock)
        begin
            if(!resetn)
                data_out <= 0;
            else if(soft_reset)
                data_out <= 8'bz;
            else if(!fifo_counter && empty)
                data_out <= 8'bz;
            else if(read_enb && !empty)
                data_out <= mem[rd_ptr[3:0]][7:0];
        end
    // Logic for write operation
    always@(posedge clock)
        begin
            if(!resetn)
                for(i=0;i<16;i=i+1)
                    mem[i] <= 0;
            else if(soft_reset)
                for(i=0;i<16;i=i+1)
                    mem[i] <= 0;
            else if(write_enb && !full)
                mem[wr_ptr[3:0]] <= {lfd_tmp,data_in};
        end
    // Logic for empty and full
    assign empty = (wr_ptr==rd_ptr)?1'b1:1'b0;
    assign full = (wr_ptr=={~rd_ptr[4],rd_ptr[3:0]})?1'b1:1'b0;
endmodule