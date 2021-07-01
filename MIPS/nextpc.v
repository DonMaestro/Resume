module nextpc(i_PC, i_Imm, i_zero, i_Bne, i_Beq, i_J, o_PC, o_PCSrc);

input	[29:0]	i_PC;
input	[25:0]	i_Imm;
input		i_zero, i_Bne, i_Beq, i_J;
output	[29:0]	o_PC;
output		o_PCSrc;

wire	[29:0]	se, mux0;



mux2in1 #(30) mux_next_pc(.i_dat0(mux0), 
	.i_dat1( {i_PC[29:26], i_Imm} ), 
	.i_control(i_J), 
	.o_dat(o_PC));

assign se = { {(29-15){i_Imm[15]}}, i_Imm[14:0] };
assign mux0 = i_PC + se;

assign o_PCSrc = ( !i_zero & i_Bne ) | i_J | ( i_zero & i_Beq );

endmodule
