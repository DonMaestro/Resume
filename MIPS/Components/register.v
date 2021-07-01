module register(i_clk, i_rst_n, i_srst, i_en, i_reg, o_reg);
parameter REG_DATA_WIDTH=32;

input               i_clk, i_en, i_srst, i_rst_n;
input       [REG_DATA_WIDTH-1:0]  i_reg;
output  reg [REG_DATA_WIDTH-1:0]  o_reg;


always @(posedge i_clk, negedge i_rst_n) begin
	if (!i_rst_n)
		o_reg <= 0;
	else
		if (i_srst)
			o_reg <= 0;
		else if (i_en)
			o_reg <= i_reg;
end
   
endmodule
