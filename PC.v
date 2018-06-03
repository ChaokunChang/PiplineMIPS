`timescale 1ns / 1ps

module PC #(parameter WIDTH = 8)
(
input clk,reset,
input [WIDTH-1:0]prePC,
output reg [WIDTH-1:0]PC
);

always@(posedge clk)
	begin
		if(reset) PC <= 0;
		else PC <= prePC;
	end

endmodule

