module router_sync(input clock,
    resetn,
    detect_add,
    write_enb_reg,
    read_enb_0,
    read_enb_1,
    read_enb_2,
    empty_0,
    empty_1,
    empty_2,
    full_0,
    full_1,
    full_2,
    input [1:0] data_in,
    output reg fifo_full,
    soft_reset_0,
    soft_reset_1,
    soft_reset_2,
    output vld_out_0,
    vld_out_1,
    vld_out_2,
    output reg [2:0] write_enb);
    reg[1:0] fifo_addr;
    reg[4:0] timer_0,timer_1,timer_2;
    // Logic for storing address
    always@(posedge clock)
    begin
        if(!resetn)
            fifo_addr <= 0;
        else if(detect_add)
            fifo_addr <= data_in;
    end
    // Logic for fifo full status
    always@(*)
    begin
        if(!resetn)
            fifo_full = 0;
        else
            begin
                case(fifo_addr)
                2'b00 : fifo_full = full_0;
                2'b01 : fifo_full = full_1;
                2'b10 : fifo_full = full_2;
                default: fifo_full = 0;
                endcase
            end
    end
    // Logic for write enable
    always@(*)
    begin
        if(!resetn)
            write_enb = 0;
        else if(write_enb_reg)
            begin
                case(fifo_addr)
                2'b00 : write_enb = 3'b001;
                2'b01 : write_enb = 3'b010;
                2'b10 : write_enb = 3'b100;
                default : write_enb = 3'b0;
                endcase
            end
        else
            write_enb = 0;
    end
    // Logic for valid out signal
    assign vld_out_0 = ~empty_0;
    assign vld_out_1 = ~empty_1;
    assign vld_out_2 = ~empty_2;
    // Logic for soft reset 0
    always@(posedge clock)
    begin
        if(!resetn)
            begin
                soft_reset_0 <= 0;
                timer_0 <= 0;
            end
        else if(~vld_out_0)
            begin
                soft_reset_0 <= 0;
                timer_0 <= 0;
            end
        else if(read_enb_0)
            begin
                soft_reset_0 <= 0;
                timer_0 <= 0;
            end
        else
            begin
                if(timer_0 == 5'd29)
                    begin
                        soft_reset_0 <= 1'b1;
                        timer_0 <= 0;
                    end
                else
                    begin
                        timer_0 <= timer_0 + 1'b1;
                        soft_reset_0 <= 0;
                    end
            end
    end
    // Logic for soft reset 1
    always@(posedge clock)
    begin
        if(!resetn)
            begin
                soft_reset_1 <= 0;
                timer_1 <= 0;
            end
        else if(~vld_out_1)
            begin
                soft_reset_1 <= 0;
                timer_1 <= 0;
            end
        else if(read_enb_1)
            begin
                soft_reset_1 <= 0;
                timer_1 <= 0;
            end
        else
            begin
                if(timer_1 == 5'd29)
                    begin
                        soft_reset_1 <= 1'b1;
                        timer_1 <= 0;
                    end
                else
                    begin
                        timer_1 <= timer_1 + 1'b1;
                        soft_reset_1 <= 0;
                    end
            end
    end
    // Logic for soft reset 2
    always@(posedge clock)
        begin
            if(!resetn)
                begin
                    soft_reset_2 <= 0;
                    timer_2 <= 0;
                end
            else if(~vld_out_2)
                begin
                    soft_reset_2 <= 0;
                    timer_2 <= 0;
                end
            else if(read_enb_2)
                begin
                    soft_reset_2 <= 0;
                    timer_2 <= 0;
                end
            else
                begin
                    if(timer_2 == 5'd29)
                        begin
                            soft_reset_2 <= 1'b1;
                            timer_2 <= 0;
                        end
                    else
                        begin
                            timer_2 <= timer_2 + 1'b1;
                            soft_reset_2 <= 0;
                        end
                end
        end
endmodule
