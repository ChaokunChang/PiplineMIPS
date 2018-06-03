`timescale 1ns / 1ps
//aludec
module aludec(
	input [1:0]aluop,
	input [5:0]func,
	output reg shift,
	output reg [2:0]alucontrol
);
	always @(*)
	case(aluop)
		2'b00: begin alucontrol = 3'b010; shift = 0; end //add
		2'b01: begin alucontrol = 3'b110; shift = 0; end//sub
		2'b11: begin alucontrol = 3'b001; shift = 0; end//or
		2'b10: //look at func
			case(func)
				6'b000000: begin alucontrol = 3'b011; shift = 1; end //SLL/nop 
				6'b100000: begin alucontrol = 3'b010; shift = 0; end //add
				6'b100010: begin alucontrol = 3'b110; shift = 0; end //sub
				6'b100100: begin alucontrol = 3'b000; shift = 0; end //and
				6'b100101: begin alucontrol = 3'b001; shift = 0; end //or
				6'b101010: begin alucontrol = 3'b111; shift = 0; end //slt 
				6'b000100: begin alucontrol = 3'b011; shift = 0; end //SLLV
				6'b000011: begin alucontrol = 3'b100; shift = 1; end //SRA
				6'b000111: begin alucontrol = 3'b100; shift = 0; end //SRAV
				6'b000010: begin alucontrol = 3'b101; shift = 1; end //SRL
				6'b000110: begin alucontrol = 3'b101; shift = 0; end //SRLV
				default:   begin alucontrol = 3'b011; shift = 0; end //default 
			endcase
	endcase

endmodule

