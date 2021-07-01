module mux2in1(i_dat0, i_dat1, i_control, o_dat);

parameter WIDTH = 32;

input   [WIDTH-1:0]   i_dat0, i_dat1; 
input                 i_control;
output  [WIDTH-1:0]   o_dat;
  



reg	[WIDTH-1:0]	o_reg;


always @(*) begin
	case (i_control)
		0: o_reg <= i_dat0;
		1: o_reg <= i_dat1;
	endcase
end


assign o_dat = o_reg;


endmodule
