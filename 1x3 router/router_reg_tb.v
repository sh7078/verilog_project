module router_reg_tb();
    reg clock,resetn,pkt_valid,fifo_full,rst_int_reg,detect_add,ld_state,laf_state,full_state,lfd_state;
    reg [7:0] data_in;
    wire parity_done,low_pkt_valid,err;
    wire [7:0] dout;
    parameter T = 10;
    integer i;
    router_reg DUT (clock,
        resetn,
        pkt_valid,
        fifo_full,
        rst_int_reg,
        detect_add,
        ld_state,
        laf_state,
        full_state,
        lfd_state,
        data_in,
        parity_done,
        low_pkt_valid,
        err, dout);
    initial
    begin
        clock = 1'b0;
        forever #(T/2) clock = ~clock;
    end
    task initialize;
    begin
        resetn = 1'b1;
        pkt_valid =1'b0;
        fifo_full = 1'b0;
        rst_int_reg = 1'b0;
        detect_add = 1'b0;
        ld_state = 1'b0;
        laf_state = 1'b0;
        full_state = 1'b0;
        lfd_state = 1'b0;
        data_in = 0;
    end
    endtask
    task resetn_ip;
    begin
        @(negedge clock);
        resetn = 1'b0;
        @(negedge clock);
        resetn = 1'b1;
    end
    endtask
    task good_packet;
        reg [7:0] header, payload, parity;
        reg [5:0] payload_len;
        reg [1:0] addr;
        begin
            @(negedge clock);
            parity = 0;
            payload_len = 6'd4;
            addr = 2'd1;
            header = {payload_len,addr};
            pkt_valid = 1'b1;
            detect_add = 1'b1;
            parity = parity ^ header;
            data_in = header;
            @(negedge clock);
            detect_add = 0;
            lfd_state = 1'b1;
            for(i=0;i<payload_len;i=i+1)
            begin
                @(negedge clock);
                lfd_state = 0;
                ld_state = 1;
                payload = {$random} % 256;
                parity = parity ^ payload;
                data_in = payload;
            end
            @(negedge clock);
            pkt_valid = 0;
            data_in = parity;
            @(negedge clock);
            ld_state = 0;
            rst_int_reg = 1'b1;
            @(negedge clock);
            rst_int_reg = 1'b0;
            detect_add = 1'b1;
        end
    endtask
    task overflow_packet;
        reg [7:0] header, payload, parity;
        reg [5:0] payload_len;
        reg [1:0] addr;
        begin
            @(negedge clock);
            parity = 0;
            payload_len = 6'd16;
            addr = 2'd2;
            header = {payload_len,addr};
            pkt_valid = 1'b1;
            detect_add = 1'b1;
            parity = parity ^ header;
            data_in = header;
            @(negedge clock);
            detect_add = 0;
            lfd_state = 1'b1;
            for(i=0;i<15;i=i+1)
            begin
                @(negedge clock);
                lfd_state = 0;
                ld_state = 1;
                payload = {$random} % 256;
                parity = parity ^ payload;
                data_in = payload;
            end
            @(negedge clock);
            payload = 8'b11110000;
            parity = parity ^ payload;
            data_in = payload;
            fifo_full = 1'b1;
            full_state = 1'b1;
            #30 fifo_full = 0;
            full_state = 0;
            ld_state = 0;
            @(negedge clock);
            laf_state = 1'b1;
            @(negedge clock);
            laf_state = 0;
            ld_state = 1'b1;
            @(negedge clock);
            pkt_valid = 0;
            data_in = parity;
            @(negedge clock);
            ld_state = 0;
            rst_int_reg = 1'b1;
            @(negedge clock);
            rst_int_reg = 1'b0;
            detect_add = 1'b1;
        end
    endtask
    task corrupted_packet;
        reg [7:0] header, payload, parity;
        reg [5:0] payload_len;
        reg [1:0] addr;
        begin
            @(negedge clock);
            parity = 0;
            payload_len = 6'd4;
            addr = 2'd1;
            header = {payload_len,addr};
            pkt_valid = 1'b1;
            detect_add = 1'b1;
            parity = parity ^ header;
            data_in = header;
            @(negedge clock);
            detect_add = 0;
            lfd_state = 1'b1;
            for(i=0;i<payload_len;i=i+1)
            begin
                @(negedge clock);
                lfd_state = 0;
                ld_state = 1;
                payload = {$random} % 256;
                parity = parity ^ payload;
                data_in = payload;
            end
            @(negedge clock);
            pkt_valid = 0;
            data_in = ~parity;
            @(negedge clock);
            ld_state = 0;
            rst_int_reg = 1'b1;
            @(negedge clock);
            rst_int_reg = 1'b0;
            detect_add = 1'b1;
        end
    endtask
    initial
    begin
        initialize;
        #20;
        resetn_ip;
        #20;
        good_packet;
        #200;
        corrupted_packet;
        #200;
        overflow_packet;
        #200;
        $finish;
    end
endmodule