////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: fifo_synthesis.v
// /___/   /\     Timestamp: Sun Jun 27 09:17:04 2021
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim fifo.ngc fifo_synthesis.v 
// Device	: xc6slx9-3-tqg144
// Input file	: fifo.ngc
// Output file	: D:\Project\fifo\netgen\synthesis\fifo_synthesis.v
// # of Modules	: 1
// Design Name	: fifo
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module fifo (
  i_clk, i_rst_n, i_re, i_we, o_overflow, o_empty, i_fifo, o_fifo
);
  input i_clk;
  input i_rst_n;
  input i_re;
  input i_we;
  output o_overflow;
  output o_empty;
  input [7 : 0] i_fifo;
  output [7 : 0] o_fifo;
  wire i_fifo_7_IBUF_0;
  wire i_fifo_6_IBUF_1;
  wire i_fifo_5_IBUF_2;
  wire i_fifo_4_IBUF_3;
  wire i_fifo_3_IBUF_4;
  wire i_fifo_2_IBUF_5;
  wire i_fifo_1_IBUF_6;
  wire i_fifo_0_IBUF_7;
  wire i_clk_BUFGP_8;
  wire i_rst_n_IBUF_9;
  wire i_re_IBUF_10;
  wire i_we_IBUF_11;
  wire o_fifo_7_OBUF_12;
  wire o_fifo_6_OBUF_13;
  wire o_fifo_5_OBUF_14;
  wire o_fifo_4_OBUF_15;
  wire o_fifo_3_OBUF_16;
  wire o_fifo_2_OBUF_17;
  wire o_fifo_1_OBUF_18;
  wire o_fifo_0_OBUF_19;
  wire reg_re;
  wire enable_write;
  wire reg_we;
  wire o_empty_OBUF_25;
  wire o_overflow_OBUF_26;
  wire N0;
  wire i_rst_n_inv;
  wire \head_addr[2]_end_addr[2]_equal_4_o32 ;
  wire N4;
  wire N6;
  wire \counter_end/count_0_rstpot_60 ;
  wire \counter_end/count_1_rstpot_61 ;
  wire \counter_end/count_2_rstpot_62 ;
  wire \counter_head/count_0_rstpot_63 ;
  wire \counter_head/count_1_rstpot_64 ;
  wire \counter_head/count_2_rstpot_65 ;
  wire N10;
  wire N14;
  wire N16;
  wire N20;
  wire \NLW_Mram_ram1_DOD<1>_UNCONNECTED ;
  wire \NLW_Mram_ram1_DOD<0>_UNCONNECTED ;
  wire NLW_Mram_ram22_SPO_UNCONNECTED;
  wire NLW_Mram_ram21_SPO_UNCONNECTED;
  wire [1 : 0] buf_rw;
  wire [2 : 0] \counter_head/count ;
  wire [2 : 0] \counter_end/count ;
  GND   XST_GND (
    .G(N0)
  );
  FDP #(
    .INIT ( 1'b1 ))
  register_re (
    .C(i_clk_BUFGP_8),
    .D(reg_re),
    .PRE(i_rst_n_IBUF_9),
    .Q(buf_rw[1])
  );
  FDC #(
    .INIT ( 1'b0 ))
  register_we (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_IBUF_9),
    .D(reg_we),
    .Q(buf_rw[0])
  );
  RAM32M #(
    .INIT_A ( 64'h0000000000000000 ),
    .INIT_B ( 64'h0000000000000000 ),
    .INIT_C ( 64'h0000000000000000 ),
    .INIT_D ( 64'h0000000000000000 ))
  Mram_ram1 (
    .WCLK(i_clk_BUFGP_8),
    .WE(enable_write),
    .DIA({i_fifo_1_IBUF_6, i_fifo_0_IBUF_7}),
    .DIB({i_fifo_3_IBUF_4, i_fifo_2_IBUF_5}),
    .DIC({i_fifo_5_IBUF_2, i_fifo_4_IBUF_3}),
    .DID({N0, N0}),
    .ADDRA({N0, N0, \counter_head/count [2], \counter_head/count [1], \counter_head/count [0]}),
    .ADDRB({N0, N0, \counter_head/count [2], \counter_head/count [1], \counter_head/count [0]}),
    .ADDRC({N0, N0, \counter_head/count [2], \counter_head/count [1], \counter_head/count [0]}),
    .ADDRD({N0, N0, \counter_end/count [2], \counter_end/count [1], \counter_end/count [0]}),
    .DOA({o_fifo_1_OBUF_18, o_fifo_0_OBUF_19}),
    .DOB({o_fifo_3_OBUF_16, o_fifo_2_OBUF_17}),
    .DOC({o_fifo_5_OBUF_14, o_fifo_4_OBUF_15}),
    .DOD({\NLW_Mram_ram1_DOD<1>_UNCONNECTED , \NLW_Mram_ram1_DOD<0>_UNCONNECTED })
  );
  RAM16X1D #(
    .INIT ( 16'h0000 ))
  Mram_ram22 (
    .A0(\counter_end/count [0]),
    .A1(\counter_end/count [1]),
    .A2(\counter_end/count [2]),
    .A3(N0),
    .D(i_fifo_7_IBUF_0),
    .DPRA0(\counter_head/count [0]),
    .DPRA1(\counter_head/count [1]),
    .DPRA2(\counter_head/count [2]),
    .DPRA3(N0),
    .WCLK(i_clk_BUFGP_8),
    .WE(enable_write),
    .SPO(NLW_Mram_ram22_SPO_UNCONNECTED),
    .DPO(o_fifo_7_OBUF_12)
  );
  RAM16X1D #(
    .INIT ( 16'h0000 ))
  Mram_ram21 (
    .A0(\counter_end/count [0]),
    .A1(\counter_end/count [1]),
    .A2(\counter_end/count [2]),
    .A3(N0),
    .D(i_fifo_6_IBUF_1),
    .DPRA0(\counter_head/count [0]),
    .DPRA1(\counter_head/count [1]),
    .DPRA2(\counter_head/count [2]),
    .DPRA3(N0),
    .WCLK(i_clk_BUFGP_8),
    .WE(enable_write),
    .SPO(NLW_Mram_ram21_SPO_UNCONNECTED),
    .DPO(o_fifo_6_OBUF_13)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \head_addr[2]_end_addr[2]_equal_4_o321  (
    .I0(\counter_head/count [0]),
    .I1(\counter_end/count [0]),
    .O(\head_addr[2]_end_addr[2]_equal_4_o32 )
  );
  LUT6 #(
    .INIT ( 64'h8008000000008008 ))
  o_empty1 (
    .I0(buf_rw[1]),
    .I1(\head_addr[2]_end_addr[2]_equal_4_o32 ),
    .I2(\counter_end/count [2]),
    .I3(\counter_head/count [2]),
    .I4(\counter_end/count [1]),
    .I5(\counter_head/count [1]),
    .O(o_empty_OBUF_25)
  );
  LUT6 #(
    .INIT ( 64'h8008000000008008 ))
  o_overflow1 (
    .I0(buf_rw[0]),
    .I1(\head_addr[2]_end_addr[2]_equal_4_o32 ),
    .I2(\counter_end/count [2]),
    .I3(\counter_head/count [2]),
    .I4(\counter_end/count [1]),
    .I5(\counter_head/count [1]),
    .O(o_overflow_OBUF_26)
  );
  IBUF   i_fifo_7_IBUF (
    .I(i_fifo[7]),
    .O(i_fifo_7_IBUF_0)
  );
  IBUF   i_fifo_6_IBUF (
    .I(i_fifo[6]),
    .O(i_fifo_6_IBUF_1)
  );
  IBUF   i_fifo_5_IBUF (
    .I(i_fifo[5]),
    .O(i_fifo_5_IBUF_2)
  );
  IBUF   i_fifo_4_IBUF (
    .I(i_fifo[4]),
    .O(i_fifo_4_IBUF_3)
  );
  IBUF   i_fifo_3_IBUF (
    .I(i_fifo[3]),
    .O(i_fifo_3_IBUF_4)
  );
  IBUF   i_fifo_2_IBUF (
    .I(i_fifo[2]),
    .O(i_fifo_2_IBUF_5)
  );
  IBUF   i_fifo_1_IBUF (
    .I(i_fifo[1]),
    .O(i_fifo_1_IBUF_6)
  );
  IBUF   i_fifo_0_IBUF (
    .I(i_fifo[0]),
    .O(i_fifo_0_IBUF_7)
  );
  IBUF   i_rst_n_IBUF (
    .I(i_rst_n),
    .O(i_rst_n_IBUF_9)
  );
  IBUF   i_re_IBUF (
    .I(i_re),
    .O(i_re_IBUF_10)
  );
  IBUF   i_we_IBUF (
    .I(i_we),
    .O(i_we_IBUF_11)
  );
  OBUF   o_fifo_7_OBUF (
    .I(o_fifo_7_OBUF_12),
    .O(o_fifo[7])
  );
  OBUF   o_fifo_6_OBUF (
    .I(o_fifo_6_OBUF_13),
    .O(o_fifo[6])
  );
  OBUF   o_fifo_5_OBUF (
    .I(o_fifo_5_OBUF_14),
    .O(o_fifo[5])
  );
  OBUF   o_fifo_4_OBUF (
    .I(o_fifo_4_OBUF_15),
    .O(o_fifo[4])
  );
  OBUF   o_fifo_3_OBUF (
    .I(o_fifo_3_OBUF_16),
    .O(o_fifo[3])
  );
  OBUF   o_fifo_2_OBUF (
    .I(o_fifo_2_OBUF_17),
    .O(o_fifo[2])
  );
  OBUF   o_fifo_1_OBUF (
    .I(o_fifo_1_OBUF_18),
    .O(o_fifo[1])
  );
  OBUF   o_fifo_0_OBUF (
    .I(o_fifo_0_OBUF_19),
    .O(o_fifo[0])
  );
  OBUF   o_overflow_OBUF (
    .I(o_overflow_OBUF_26),
    .O(o_overflow)
  );
  OBUF   o_empty_OBUF (
    .I(o_empty_OBUF_25),
    .O(o_empty)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  o_overflow1_SW0 (
    .I0(\counter_head/count [1]),
    .I1(\counter_end/count [1]),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h2AA2AAAAAAAAAAAA ))
  enable_write1 (
    .I0(i_we_IBUF_11),
    .I1(buf_rw[0]),
    .I2(\counter_head/count [2]),
    .I3(\counter_end/count [2]),
    .I4(N4),
    .I5(\head_addr[2]_end_addr[2]_equal_4_o32 ),
    .O(enable_write)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  o_empty1_SW0 (
    .I0(\counter_head/count [2]),
    .I1(\counter_end/count [2]),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'hEAAEAAAAAAAAAAAA ))
  reg_re1 (
    .I0(i_re_IBUF_10),
    .I1(buf_rw[1]),
    .I2(\counter_head/count [1]),
    .I3(\counter_end/count [1]),
    .I4(N6),
    .I5(\head_addr[2]_end_addr[2]_equal_4_o32 ),
    .O(reg_re)
  );
  LUT6 #(
    .INIT ( 64'hEAAEAAAAAAAAAAAA ))
  reg_we1 (
    .I0(i_we_IBUF_11),
    .I1(buf_rw[0]),
    .I2(\counter_head/count [1]),
    .I3(\counter_end/count [1]),
    .I4(N6),
    .I5(\head_addr[2]_end_addr[2]_equal_4_o32 ),
    .O(reg_we)
  );
  FDC   \counter_end/count_0  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_end/count_0_rstpot_60 ),
    .Q(\counter_end/count [0])
  );
  FDC   \counter_end/count_1  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_end/count_1_rstpot_61 ),
    .Q(\counter_end/count [1])
  );
  FDC   \counter_end/count_2  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_end/count_2_rstpot_62 ),
    .Q(\counter_end/count [2])
  );
  FDC   \counter_head/count_0  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_head/count_0_rstpot_63 ),
    .Q(\counter_head/count [0])
  );
  FDC   \counter_head/count_1  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_head/count_1_rstpot_64 ),
    .Q(\counter_head/count [1])
  );
  FDC   \counter_head/count_2  (
    .C(i_clk_BUFGP_8),
    .CLR(i_rst_n_inv),
    .D(\counter_head/count_2_rstpot_65 ),
    .Q(\counter_head/count [2])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  enable_read1_cepot_SW0 (
    .I0(buf_rw[1]),
    .I1(\counter_head/count [2]),
    .I2(\counter_end/count [2]),
    .O(N10)
  );
  LUT4 #(
    .INIT ( 16'hD515 ))
  enable_read1_cepot_SW2 (
    .I0(\counter_head/count [2]),
    .I1(\counter_end/count [1]),
    .I2(buf_rw[1]),
    .I3(\counter_end/count [2]),
    .O(N14)
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  enable_write1_cepot_SW0 (
    .I0(buf_rw[0]),
    .I1(\counter_head/count [2]),
    .I2(\counter_end/count [2]),
    .O(N16)
  );
  LUT4 #(
    .INIT ( 16'hD515 ))
  enable_write1_cepot_SW2 (
    .I0(\counter_end/count [2]),
    .I1(\counter_head/count [1]),
    .I2(buf_rw[0]),
    .I3(\counter_head/count [2]),
    .O(N20)
  );
  LUT6 #(
    .INIT ( 64'hE66E666626626666 ))
  \counter_head/count_0_rstpot  (
    .I0(\counter_head/count [0]),
    .I1(i_re_IBUF_10),
    .I2(\counter_head/count [1]),
    .I3(\counter_end/count [1]),
    .I4(N10),
    .I5(\counter_end/count [0]),
    .O(\counter_head/count_0_rstpot_63 )
  );
  LUT6 #(
    .INIT ( 64'hEC4C6C6C6C6C6C6C ))
  \counter_head/count_1_rstpot  (
    .I0(i_re_IBUF_10),
    .I1(\counter_head/count [1]),
    .I2(\counter_head/count [0]),
    .I3(\counter_end/count [1]),
    .I4(\counter_end/count [0]),
    .I5(N10),
    .O(\counter_head/count_1_rstpot_64 )
  );
  LUT6 #(
    .INIT ( 64'hEAAA6AAA2AAA6AAA ))
  \counter_head/count_2_rstpot  (
    .I0(\counter_head/count [2]),
    .I1(i_re_IBUF_10),
    .I2(\counter_head/count [0]),
    .I3(\counter_head/count [1]),
    .I4(\counter_end/count [0]),
    .I5(N14),
    .O(\counter_head/count_2_rstpot_65 )
  );
  LUT6 #(
    .INIT ( 64'hE66E666626626666 ))
  \counter_end/count_0_rstpot  (
    .I0(\counter_end/count [0]),
    .I1(i_we_IBUF_11),
    .I2(\counter_head/count [1]),
    .I3(\counter_end/count [1]),
    .I4(N16),
    .I5(\counter_head/count [0]),
    .O(\counter_end/count_0_rstpot_60 )
  );
  LUT6 #(
    .INIT ( 64'hEC4C6C6C6C6C6C6C ))
  \counter_end/count_1_rstpot  (
    .I0(i_we_IBUF_11),
    .I1(\counter_end/count [1]),
    .I2(\counter_end/count [0]),
    .I3(\counter_head/count [1]),
    .I4(\counter_head/count [0]),
    .I5(N16),
    .O(\counter_end/count_1_rstpot_61 )
  );
  LUT6 #(
    .INIT ( 64'hEAAA6AAA2AAA6AAA ))
  \counter_end/count_2_rstpot  (
    .I0(\counter_end/count [2]),
    .I1(i_we_IBUF_11),
    .I2(\counter_end/count [0]),
    .I3(\counter_end/count [1]),
    .I4(\counter_head/count [0]),
    .I5(N20),
    .O(\counter_end/count_2_rstpot_62 )
  );
  BUFGP   i_clk_BUFGP (
    .I(i_clk),
    .O(i_clk_BUFGP_8)
  );
  INV   i_rst_n_inv1_INV_0 (
    .I(i_rst_n_IBUF_9),
    .O(i_rst_n_inv)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

