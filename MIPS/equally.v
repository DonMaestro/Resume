module equally(i_dat0, i_dat1, o_equ);

input	[31:0]	i_dat0, i_dat1;
output		o_equ;

assign o_equ = (i_dat0 == i_dat1) ? 1 : 0;


endmodule
