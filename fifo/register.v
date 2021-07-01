`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:43 06/26/2021 
// Design Name: 
// Module Name:    register 
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
module register
	#(WIDTH = 8)(
	input						i_clk,
	input						i_rst_n,
	input						i_st_n,
	input		[WIDTH-1:0]		i_D,
	output reg	[WIDTH-1:0]		o_Q
	);


always @(posedge i_clk or negedge i_rst_n)
begin
	if(!i_rst_n)
		o_Q <= 0;
	else if(!i_st_n)
		o_Q <= 1;
	else
		o_Q <= i_D;
end

endmodule
