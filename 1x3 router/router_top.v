`include "router_fifo.v"
`include "router_fsm.v"
`include "router_sync.v"
`include "router_reg.v"

module router_top(input clock,
    resetn,
    read_enb_0,
    read_enb_1,
    read_enb_2,
    pkt_valid,
    input [7:0] data_in,
    output vld_out_0,
    vld_out_1,
    vld_out_2,
    err,
    busy,
    output [7:0] data_out_0,
    data_out_1,
    data_out_2);
    wire [2:0] write_enb;
    wire [7:0] dout;
    wire parity_done,soft_reset_0,soft_reset_1,soft_reset_2,fifo_full,low_pkt_valid,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state,empty_0,empty_1,empty_2,full_0,full_1,full_2;
    router_fsm FSM(clock,resetn,pkt_valid,parity_done,soft_reset_0,soft_reset_1,soft_reset_2,fifo_full,low_pkt_valid,empty_0,empty_1,empty_2,data_in[1:0],busy,detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state);
    router_sync Synchronizer(clock,resetn,detect_add,write_enb_reg,read_enb_0,read_enb_1,read_enb_2,empty_0,empty_1,empty_2,full_0,full_1,full_2,data_in[1:0],fifo_full,soft_reset_0,soft_reset_1,soft_reset_2,vld_out_0,vld_out_1,vld_out_2,write_enb);
    router_reg Register(clock,resetn,pkt_valid,fifo_full,rst_int_reg,detect_add,ld_state,laf_state,full_state,lfd_state,data_in,parity_done,low_pkt_valid,err,dout);
    router_fifo FIFO_0(clock,resetn,write_enb[0],soft_reset_0,read_enb_0,lfd_state,dout,empty_0,full_0,data_out_0);
    router_fifo FIFO_1(clock,resetn,write_enb[1],soft_reset_1,read_enb_1,lfd_state,dout,empty_1,full_1,data_out_1);
    router_fifo FIFO_2(clock,resetn,write_enb[2],soft_reset_2,read_enb_2,lfd_state,dout,empty_2,full_2,data_out_2);
endmodule