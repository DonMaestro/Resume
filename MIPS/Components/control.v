module control(i_instrCode, 
               o_regDst,
               o_jump, 
               o_branch,
               o_memToReg,
               o_aluOp,
               o_memWrite,
               o_memRead,
               o_aluSrc,
               o_regWrite
               );
               
// if {Op_code[31:26], func[5:0]} when input [11:0] i_instrCode; 
//if only Op_code[31:26] - when   input [5:0] i_instrCode; 
 
input     [11:0]  i_instrCode;
//input     [5:0]  i_instrCode; 
output reg           o_regDst;
output reg           o_jump; 
output reg           o_branch;
output reg           o_memToReg;
output reg   [1:0]   o_aluOp;
output reg           o_memWrite;
output reg           o_memRead;
output reg           o_aluSrc;
output reg          o_regWrite;


//localparam 

// R-type add sub or and addu subu
// I-type beq sw lw addi addiu
// J-type j


always @(i_instrCode) begin
	casez(i_instrCode)
	//R-type
		12'b000000_??????: begin 
			o_regDst <= 1'b1;
			o_regWrite <= 1'b1;
			o_aluOp <= 2'b10;
			o_aluSrc <= 1'b0;
			
			o_branch <= 1'b0;
			o_jump <= 1'b0;
			o_memWrite <= 1'b0;
			o_memRead <= 1'b0;
			o_memToReg <= 1'b0;
		end
	//I-type
		12'b000100_??????: begin //beq
			o_regDst <= 1'bx;
			o_regWrite <= 1'b0;
			o_aluOp <= 2'b01;
			o_aluSrc <= 1'b0;
			
			o_branch <= 1'b1;
			o_jump <= 1'b0;
			o_memWrite <= 1'b0;
			o_memRead <= 1'b0;
			o_memToReg <= 1'bx;
		end
		12'b101011_??????: begin //sw
			o_regDst <= 1'bx;
			o_regWrite <= 1'b0;
			o_aluOp <= 2'b00;
			o_aluSrc <= 1'b1;
			
			o_branch <= 1'b0;
			o_jump <= 1'b0;
			o_memWrite <= 1'b1;
			o_memRead <= 1'b0;
			o_memToReg <= 1'bx;
		end
		12'b100011_??????: begin //lw
			o_regDst <= 1'b0;
			o_regWrite <= 1'b1;
			o_aluOp <= 2'b00;
			o_aluSrc <= 1'b1;
			
			o_branch <= 1'b0;
			o_jump <= 1'b0;
			o_memWrite <= 1'b0;
			o_memRead <= 1'b1;
			o_memToReg <= 1'b1;
		end
		12'b00100?_??????: begin //addi and addiu
			o_regDst <= 1'b0;
			o_regWrite <= 1'b1;
			o_aluOp <= 2'b00;
			o_aluSrc <= 1'b1;
			
			o_branch <= 1'b0;
			o_jump <= 1'b0;
			o_memWrite <= 1'b0;
			o_memRead <= 1'b0;
			o_memToReg <= 1'b0;
		end

	//J-type
		12'b000010_??????: begin //j
			o_regDst <= 1'bx;
			o_regWrite <= 1'b0;
			o_aluOp <= 2'bxx;
			o_aluSrc <= 1'bx;
			
			o_branch <= 1'b0;
			o_jump <= 1'b1;
			o_memWrite <= 1'b0;
			o_memRead <= 1'b0;
			o_memToReg <= 1'bx;
		end
	endcase
end


endmodule
