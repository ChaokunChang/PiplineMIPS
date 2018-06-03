`timescale 1ns / 1ps

module RegFile(
	input clk,CU_WE,
	input [4:0]ReadReg1,
	input [4:0]ReadReg2,
	input [4:0]WriteReg,
	input [31:0]WriteData,
	output [31:0]ReadData1,
	output [31:0]ReadData2,
	input [4:0]cn4,
	output [31:0]disdata
);

reg [31:0] register [31:0];

always @(negedge clk)
if(CU_WE==1) register[WriteReg] <= WriteData;

assign ReadData1 = (ReadReg1==0) ? 0 : register[ReadReg1];
assign ReadData2 = (ReadReg2==0) ? 0 : register[ReadReg2];
assign disdata = register[cn4];

endmodule






