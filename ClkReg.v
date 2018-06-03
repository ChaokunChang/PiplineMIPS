`timescale 1ns / 1ps
module flopr #(parameter W = 32)(
	input clk,reset,
	input [W-1:0]d,
	output reg [W-1:0]q
);

always @(posedge clk, posedge reset)
	if(reset) q <= 0;
	else q<= d;

endmodule


module floprc #(parameter W = 32)(
	input clk,reset,clear,
	input [W-1:0]d,
	output reg [W-1:0]q
);

always @(posedge clk, posedge reset)
	if(reset) q <= 0;
	else if(clear) q <= 0;
	else q<= d;

endmodule


module flopenr #(parameter W = 32)(
	input clk,reset,en,
	input [W-1:0]d,
	output reg [W-1:0]q
);

always @(posedge clk, posedge reset)
	if(reset) q <= 0;
	else if(en) q<= d;

endmodule


module flopenrc #(parameter W = 32)(
	input clk,reset,en,clear,
	input [W-1:0]d,
	output reg [W-1:0]q
);

always @(posedge clk, posedge reset)
	if(reset) q <= 0;
	else if(clear) q <= 0;
	else if(en) q<= d;

endmodule