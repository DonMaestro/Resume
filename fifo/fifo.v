`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:47 06/26/2021 
// Design Name: 
// Module Name:    fifo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fifo 
	#(WIDTH = 8, BUF_WIDTH = 3)(
	input						i_clk,
	input						i_rst_n,
	input						i_re,
	input						i_we,
	input		[WIDTH-1:0]		i_fifo,
	output		[WIDTH-1:0]		o_fifo,
	output						o_overflow,
	output						o_empty
	);
localparam BUF_SIZE = 1 << BUF_WIDTH;


wire					clk, reset_n;

wire	[WIDTH-1:0]		fifo_write, fifo_read;

wire					en_r, en_w;

wire					overflow, empty;


assign clk = i_clk;
assign reset_n = i_rst_n;

assign o_fifo = fifo_read;
assign fifo_write = i_fifo;

assign en_r = i_re;
assign en_w = i_we;

assign o_empty = empty;
assign o_overflow = overflow;


//////////////////////////////////////////////////////////////////////////////////

reg		[WIDTH-1:0]			ram [0:BUF_SIZE-1];

wire	[BUF_WIDTH-1:0]		head_addr, end_addr;

wire	[1:0]				buf_rw;

wire						enable_write, enable_read;
wire						reg_re, reg_we;


assign empty = (head_addr == end_addr) & buf_rw[1];
assign overflow = (head_addr == end_addr) & buf_rw[0];
//assign empty = ~|(head_addr ^ end_addr) & buf_rw[1];
//assign overflow = ~|(head_addr ^ end_addr) & buf_rw[0];

assign enable_write = en_w & ~overflow;
assign enable_read = en_r & ~empty;

assign reg_re = en_r | empty;
assign reg_we = en_w | overflow;



FDP register_re (
		.Q(buf_rw[1]),      // 1-bit Data output
		.C(clk),      // 1-bit Clock input
		.PRE(~reset_n),  // 1-bit Asynchronous preset input
		.D(reg_re)       // 1-bit Data input
	);
	
FDC register_we (
		.Q(buf_rw[0]),      // 1-bit Data output
		.C(clk),      // 1-bit Clock input
		.CLR(~reset_n),  // 1-bit Asynchronous clear input
		.D(reg_we)       // 1-bit Data input
	);



counter #(.WIDTH(BUF_WIDTH)) counter_head (
		.i_clk(clk),
		.i_rst_n(reset_n),
		.i_en(enable_read),
		.o_count(head_addr)
	);

counter #(.WIDTH(BUF_WIDTH)) counter_end (
		.i_clk(clk),
		.i_rst_n(reset_n),
		.i_en(enable_write),
		.o_count(end_addr)
	);
	



assign fifo_read = ram[head_addr];

always @(posedge clk)
begin
	if(enable_write)
		ram[end_addr] <= fifo_write;
end




endmodule
