`timescale 1ns / 1ps

module DMEM(
	input clk,CU_WE,
	input [31:0]Addr,Data,
	output [31:0]Read,
	input [11:0]cn1,
	output [31:0]disdata
);

reg [31:0] RAM[63:0];

assign disdata = RAM[cn1];
assign Read = RAM[Addr[31:2]];

always @(posedge clk)
if(CU_WE) RAM[Addr[31:2]] <= Data;


endmodule



