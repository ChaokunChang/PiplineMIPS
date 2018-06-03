`timescale 1ns / 1ps

module sl2(
	input [31:0]i,
	output [31:0]o
);

assign o = {i[29:0],2'b00};

endmodule
