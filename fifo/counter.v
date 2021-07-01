`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:00 06/26/2021 
// Design Name: 
// Module Name:    counter 
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
module counter
		#(WIDTH = 4)(
		input					i_clk,
		input					i_rst_n,
		input					i_en,
		output	[WIDTH-1:0]		o_count
	);

reg	[WIDTH-1:0]	count;

assign o_count = count;

always @(posedge i_clk, negedge i_rst_n)
begin
	if(!i_rst_n)
		count <= {WIDTH{1'b0}};
	else
	begin
		if(i_en)
			count <= count + 1'b1;
	end
end


endmodule
