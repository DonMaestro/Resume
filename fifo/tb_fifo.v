`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:42:17 06/26/2021
// Design Name:   fifo
// Module Name:   D:/Project/fifo/tb_fifo.v
// Project Name:  fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_fifo;
	localparam TBWIDTH = 3, TBBUF_WIDTH = 2;

	// Inputs
	reg i_clk;
	reg i_rst_n;
	reg i_re;
	reg i_we;
	reg [TBWIDTH-1:0] i_fifo;

	// Outputs
	wire [TBWIDTH-1:0] o_fifo;
	wire o_overflow;
	wire o_empty;

	// Instantiate the Unit Under Test (UUT)
	fifo #(.WIDTH(TBWIDTH), .BUF_WIDTH(TBBUF_WIDTH)) uut (
		.i_clk(i_clk), 
		.i_rst_n(i_rst_n), 
		.i_re(i_re), 
		.i_we(i_we), 
		.i_fifo(i_fifo), 
		.o_fifo(o_fifo), 
		.o_overflow(o_overflow), 
		.o_empty(o_empty)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_rst_n = 0;
		i_re = 0;
		i_we = 0;
		i_fifo = 0;

		// Wait 100 ns for global reset to finish
		
		i_rst_n <= #100 1'b1;		
		
		// Add stimulus here
		
		i_we <= #190 1;
		i_fifo <= #190 3'b101;
		i_fifo <= #230 3'b100;
		i_fifo <= #270 3'b010;
		i_fifo <= #310 3'b111;
		
		i_we <= #350 0;
		i_fifo <= #350 3'b000;
		
		i_re <= #390 1;
		i_re <= #700 0;
		
		
	end
	
	initial #30 forever #20 i_clk = ~i_clk;
	
	
	initial begin
	//# 5000 $finish;
	end
	
endmodule

