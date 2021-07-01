module aluControl(i_aluOp, i_func, o_aluControl);
 
input       [1:0]   i_aluOp;
input       [5:0]   i_func;
output  reg [3:0]   o_aluControl;

localparam AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010;
localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100; //SOLT - Set On Less then

always @(*) begin 
	casez({i_aluOp, i_func})
		8'b00_??_????: o_aluControl = ADD;
		8'b01_??_????: o_aluControl = SUB;
		8'b10_??_0000: o_aluControl = ADD;
		8'b10_??_0010: o_aluControl = SUB;
		8'b10_??_0100: o_aluControl = AND;
		8'b10_??_0101: o_aluControl = OR;
		8'b10_??_1010: o_aluControl = SOLT;
		8'b10_??_0111: o_aluControl = NOR;
	endcase
end

endmodule
