
module regFile(i_clk, 
               i_raddr1, 
               i_raddr2, 
               i_waddr, 
               i_wdata, 
               i_we,
               o_rdata1,
               o_rdata2 
               );
               
input           i_clk, i_we;
input   [4:0]   i_raddr1, i_raddr2, i_waddr;
input   [31:0]  i_wdata;           
output  [31:0]  o_rdata1, o_rdata2;


reg	[31:0]	mem[1:31];

reg	[31:0]	o_reg1,o_reg2;

//	read

/*
always @(*) begin
	if ( i_raddr1 == 0 )
		o_reg1 <= 32'b0;
	else
		o_reg1 <= mem[i_raddr1];

	if ( i_raddr2 == 0 )
		o_reg2 <= 32'b0;
	else
		o_reg2 <= mem[i_raddr2];
end
assign o_rdata1 = o_reg1;
assign o_rdata2 = o_reg2;
*/

assign o_rdata1 = (!i_raddr1) ? 32'b0 : mem[i_raddr1];
assign o_rdata2 = (!i_raddr2) ? 32'b0 : mem[i_raddr2];



//	write

always @(posedge i_clk) begin
	if (i_we)
		if (i_waddr != 0)
			mem[i_waddr] <= i_wdata;
end

  
endmodule
