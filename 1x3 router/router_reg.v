module router_reg (input clock,
    resetn,
    pkt_valid,
    fifo_full,
    rst_int_reg,
    detect_add,
    ld_state,
    laf_state,
    full_state,
    lfd_state,
    input [7:0] data_in,
    output reg parity_done,
    low_pkt_valid,
    err,
    output reg [7:0] dout);
    reg [7:0] header_byte, fifo_full_state_byte, internal_parity, packet_parity;
    // Logic to store header byte and FIFO full state byte
    always@(posedge clock)
        begin
            if(!resetn)
                begin
                    header_byte <= 0;
                    fifo_full_state_byte <= 0;
                end
            else if(detect_add && pkt_valid)
                header_byte <= data_in;
            else if(ld_state && fifo_full)
                fifo_full_state_byte <= data_in;
        end
    // Logic for dout
    always@(posedge clock)
    begin
        if(!resetn)
            dout <= 0;
        else if(lfd_state)
            dout <= header_byte;
        else if(laf_state)
            dout <= fifo_full_state_byte;
        else if(ld_state && !fifo_full)
            dout <= data_in;
    end
    // Logic for parity_done
    always@(posedge clock)
    begin
        if(!resetn)
            parity_done <= 0;
        else if(detect_add)
            parity_done <= 0;
        else if((ld_state && !pkt_valid && !fifo_full) || (laf_state && low_pkt_valid && !parity_done))
            parity_done <= 1'b1;
    end
    // Logic for low_pkt_valid
    always@(posedge clock)
    begin
        if(!resetn)
            low_pkt_valid <= 0;
        else if(ld_state && !pkt_valid)
            low_pkt_valid <= 1'b1;
        else if(rst_int_reg)
            low_pkt_valid <= 0;
    end
    // Logic for internal_parity
    always@(posedge clock)
    begin
        if(!resetn)
            internal_parity <= 0;
        else if(detect_add)
            internal_parity <= 0;
        else if(lfd_state)
            internal_parity <= internal_parity ^ header_byte;
        else if(ld_state && pkt_valid && !full_state)
            internal_parity <= internal_parity ^ data_in;
    end
    // Logic for packet_parity
    always@(posedge clock)
    begin
        if(!resetn)
            packet_parity <= 0;
        else if((ld_state && !pkt_valid && !fifo_full) || (laf_state && low_pkt_valid && !parity_done))
            packet_parity <= data_in;
    end
    // Logic for err
    always@(posedge clock)
    begin
        if(!resetn)
            err <= 0;
        else if(parity_done && (internal_parity != packet_parity))
            err <= 1'b1;
        else
            err <= 0;
    end
endmodule