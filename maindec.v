`timescale 1ns / 1ps
//maindec
module maindec(
	input [5:0]OP,
	output M2REG,WMEM,BRANCH,ALUIMM,REGRT,WREG,JMP,
	output [1:0]ALUOP
);

reg [8:0] CONTROLS;
assign {WREG,REGRT,ALUIMM,BRANCH,JMP,WMEM,M2REG,ALUOP} = CONTROLS;

always @(*)
case(OP)
//special
	6'b000000: CONTROLS = 9'b110_00_00_10;//op:10 :look at func
//addi
	6'b001000: CONTROLS = 9'b101_00_00_00;//op:00 :add
//ori
	6'b001101: CONTROLS = 9'b101_00_00_11;//op:11 :or
//slti
	6'b001010: CONTROLS = 9'b101_00_00_01;//op:01 :substract
//sw
	6'b101011: CONTROLS = 9'b001_00_10_00;//op:00 :add
//lw
	6'b100011: CONTROLS = 9'b101_00_01_00;//op:00 :add
//j
	6'b000010: CONTROLS = 9'b000_01_00_xx;//op:xx :don't need alu,so what about give 11 ?
//beq
	6'b000100: CONTROLS = 9'b000_10_00_01;//op:00 :sub rs rt
//bne
	6'b000101: CONTROLS = 9'b000_10_00_01;//op:00 :sub rs rt //modify logic of JMP signal , consider the diffrent between beq and bne
//default
	default  : CONTROLS = 9'bxxx_xx_xx_xx;//other operations
endcase

endmodule