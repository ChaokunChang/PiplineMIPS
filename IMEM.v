`timescale 1ns / 1ps

module IMEM(
	input [5:0]PC,
	output [31:0]instr,
	input [5:0]cn1,
	output [31:0]disdata
	
);

reg [31:0] RAM[63:0];
assign disdata = RAM[cn1];

initial begin
//initialize instruction memory
	//$readmemh("E:/Vivado Files/MIPS0/memfile.dat",RAM); 
	$readmemh("E:/Vivado Files/sum.dat",RAM);
end

assign instr = RAM[PC];




endmodule
