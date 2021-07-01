module core (input clk, input rst_n);


parameter ROM_DATA_WIDTH=32, ROM_ADDR_WIDTH=8;

//wire	[ROM_DATA_WIDTH-1:0]	instruction;
//wire	[ROM_ADDR_WIDTH-1:0]	pc, new_pc, pc_branch;

//wire IF->ID->EX->MEM->WB
wire	[31:0]	reg_instr, reg_NPC;
wire	[31:0]	reg_NPC2,  reg_A, reg_B;
wire	[15:0]	reg_Imm;
wire	[31:0]	reg_ALUout, reg_D;
wire	[31:0]	reg_WBData;

wire	[4:0]	reg_Rd2, reg_Rd3, reg_Rd4;



//wire IF
wire	[31:0]	pc, addr_pc, new_addr_pc, next_addr_pc;

wire	[29:0]	pc_jump; //result Next PC for mux_new_pc
wire		PCSrc; // result Next PC for mux_new_pc




//wire ID
wire	[31:0]	o_rdata1, o_rdata2;
wire	[31:0]	forwardA, forwardB;
wire	[4:0]	addr_reg_write;


//wire EX
wire	[31:0]	sE_mux_1;
wire	[31:0]	mux_alu;
wire	[31:0]	result_alu;
wire		alu_zero; // for Next PC

//wire MEM
wire	[31:0]	o_data_memory, regFile_wdata;




//wire Control and aluControl
reg		stall;
wire	[11:0]	reg_Ex, i_regEx, c_bit;
wire	[3:0]	reg_Mem;
wire		reg_Wb;

wire	[11:0]	instrCode;
wire		c_regDst;
wire		c_jump;
wire		c_branch;
wire		c_memToReg;
wire	[1:0]	c_aluOp;
wire		c_memWrite;
wire		c_memRead;
wire		c_aluSrc;
wire		c_regWrite;

reg	[1:0]	c_forwardA, c_forwardB;

wire	[5:0]	func;
wire	[3:0]	c_aluControl;



//data Hazards
//control Hazards
wire	[31:0]	Rs, Rt;




//Control
assign func = reg_instr[5:0];
assign instrCode = {reg_instr[31:26], reg_instr[5:0]};

control mod_control(.i_instrCode(instrCode), 
	.o_regDst	(c_bit[11]),
	.o_jump		(c_bit[10]),
	.o_branch	(c_bit[9]),
	.o_memToReg	(c_bit[1]),
	.o_aluOp	(c_aluOp),
	.o_memWrite	(c_bit[3]),
	.o_memRead	(c_bit[2]),
	.o_aluSrc	(c_bit[8]),
	.o_regWrite	(c_bit[0]));

aluControl mod_aluControl(.i_aluOp(c_aluOp), 
	.i_func(func), 
	.o_aluControl(c_bit[7:4]));


mux2in1 #(12) mux_control (.i_dat0(c_bit),
        .i_dat1( 12'b0 ),
        .i_control(stall | PCSrc),
        .o_dat(i_regEx));

//reg Control

assign c_regDst =	c_bit[11];
assign c_jump =		c_bit[10];
assign c_branch =	c_bit[9];
assign c_aluSrc =	reg_Ex[8]; 
assign c_aluControl =	reg_Ex[7:4];
assign c_memWrite =	reg_Mem[3];
assign c_memRead =	reg_Mem[2];
assign c_memToReg =	reg_Mem[1];
assign c_regWrite =	reg_Wb;


register #(12) r_Ex (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(i_regEx),
        .o_reg(reg_Ex));

register #(4) r_Mem (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_Ex[3:0]),
        .o_reg(reg_Mem));

register #(1) r_Wb (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_Mem[0]),
        .o_reg(reg_Wb));
//end reg Control


//data Hazards
//control Hazards
assign Rs = reg_instr[25:21];
assign Rt = reg_instr[20:16];

always @(*) begin
	if (!rst_n) begin
		stall <= 1'b0;
	end else if (reg_Ex[2]) begin
		if ( c_forwardA || c_forwardB )
			stall <= 1'b1;
	end else
		stall <= 1'b0;
end

always @(*) begin
	if (Rs != 0 && Rs == reg_Rd2 && reg_Ex[0])
		c_forwardA <=2'b01; 
	else if (Rs != 0 && Rs == reg_Rd3 && reg_Mem[0])
		c_forwardA <=2'b10; 
	else if (Rs != 0 && Rs == reg_Rd4 && reg_Wb)
		c_forwardA <=2'b11; 
	else 
		c_forwardA <=2'b00; 
end

always @(*) begin
	if (Rt != 0 && Rt == reg_Rd2 && reg_Ex[0])
		c_forwardB <=2'b01; 
	else if (Rt != 0 && Rt == reg_Rd3 && reg_Mem[0])
		c_forwardB <=2'b10; 
	else if (Rt != 0 && Rt == reg_Rd4 && reg_Wb)
		c_forwardB <=2'b11; 
	else 
		c_forwardB <=2'b00; 
end



/*	main block	*/


//IF

adder mod_adder(.i_op1(addr_pc),
	.i_op2(32'b01),
	.o_result(next_addr_pc));

mux2in1 #(32) mux_new_pc(.i_dat0(next_addr_pc), 
	.i_dat1( { 2'b00, pc_jump } ), 
	.i_control(PCSrc), 
	.o_dat(new_addr_pc));

pc mod_pc(.i_clk(clk),
	.i_rst_n(rst_n),
	.i_en_n(stall),
	.i_pc(new_addr_pc),
	.o_pc(addr_pc));



	       
rom #(ROM_DATA_WIDTH, ROM_ADDR_WIDTH) rom_im(
	.i_addr(addr_pc[7:0]),
        .o_data(pc));


//end IF
//reg IF->ID
/*
register #(32) r_npc (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_reg(next_addr_pc),
        .o_reg(reg_NPC));
*/
register #(32) r_instruction (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(PCSrc),
	.i_en(!stall),
        .i_reg(pc),
        .o_reg(reg_instr));



//ID

nextpc mod_nextpc(.i_PC(addr_pc[29:0]), 
	.i_Imm(reg_instr[25:0]), 
	.i_zero(alu_zero), 
	.i_Bne(1'b0), 
	.i_Beq(c_branch), 
	.i_J(c_jump), 
	.o_PC(pc_jump), 
	.o_PCSrc(PCSrc));

equally mod_equally (.i_dat0(forwardA), 
	.i_dat1(forwardB), 
	.o_equ(alu_zero));


mux2in1 #(5) mux_pc_reg(.i_dat0(reg_instr[20:16]), 
	.i_dat1(reg_instr[15:11]), 
	.i_control(c_regDst), 
	.o_dat(addr_reg_write));


regFile mod_regFile(.i_clk(clk), 
	.i_raddr1(reg_instr[25:21]),
	.i_raddr2(reg_instr[20:16]),
	.i_waddr(reg_Rd4),
	.i_wdata(reg_WBData),
	.i_we(c_regWrite),
	.o_rdata1(o_rdata1),
	.o_rdata2(o_rdata2));



//ForwardA-B

mux4in1 mux_ForwardA (
	.i_dat0(o_rdata1),
	.i_dat1(result_alu),
	.i_dat2(regFile_wdata),
	.i_dat3(reg_WBData),
	.i_control(c_forwardA),
	.o_dat(forwardA));

mux4in1 mux_ForwardB (
	.i_dat0(o_rdata2),
	.i_dat1(result_alu),
	.i_dat2(regFile_wdata),
	.i_dat3(reg_WBData),
	.i_control(c_forwardB),
	.o_dat(forwardB));

//end ID 
//reg ID->IX
/*
register #(32) r_npc2 (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_reg(next_addr_pc),
        .o_reg(reg_NPC2));
*/
register #(16) r_imm (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_instr[15:0]),
        .o_reg(reg_Imm));

register #(32) r_A (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(forwardA),
        .o_reg(reg_A));

register #(32) r_B (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(forwardB),
        .o_reg(reg_B));

register #(5) r_Rd2 (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(addr_reg_write),
        .o_reg(reg_Rd2));



//EX

signExtend mod_signEntend(.i_data(reg_Imm),
	.en(1'b1),
	.o_data(sE_mux_1));

mux2in1 mux_alu_(.i_dat0(reg_B), 
	.i_dat1(sE_mux_1), 
	.i_control(c_aluSrc), 
	.o_dat(mux_alu));


alu mod_alu(.i_op1(reg_A), 
	.i_op2(mux_alu), 
	.i_control(c_aluControl), 
	.o_result(result_alu), 
	.o_zf());			//alu_zero
			

//end EX
//reg EX->MEM
register #(32) r_ALUout (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(result_alu),
        .o_reg(reg_ALUout));

register #(32) r_D (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_B),
        .o_reg(reg_D));

register #(5) r_Rd3 (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_Rd2),
        .o_reg(reg_Rd3));



//MEM

ram mod_ram(.i_clk(clk), 
	.i_addr(reg_ALUout[4:0]), 
	.i_data(reg_D), 
	.i_we(c_memWrite), 
	.o_data(o_data_memory));

mux2in1 mux_alu_memory(.i_dat0(reg_ALUout), 
	.i_dat1(o_data_memory), 
	.i_control(c_memToReg), 
	.o_dat(regFile_wdata));


//end MEM
//reg MEM->WB
register #(32) r_WBData (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(regFile_wdata),
        .o_reg(reg_WBData));

register #(5) r_Rd4 (.i_clk(clk),
        .i_rst_n(rst_n),
        .i_srst(1'b0),
	.i_en(1'b1),
        .i_reg(reg_Rd3),
        .o_reg(reg_Rd4));
//WB


endmodule



