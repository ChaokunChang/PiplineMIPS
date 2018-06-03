`timescale 1ns / 1ps

module MIPS(
	input clk,reset,
	output [31:0]pcF,
	input [31:0]instrF,
	output memwriteM,
	output [31:0]aluoutM,writedataM,
	input [31:0]readdataM,
	input [10:0]cn1,
	output reg [31:0]disdata
);

wire [31:0]cudata,dpdata;
wire [1:0]cn2;
wire [8:0]cn3;
wire [2:0]cnt3;
assign cn2 = cn1[10:9];
assign cn3 = cn1[8:0];
assign cnt3 = cn1[8:6];


wire [5:0]opD,funcD;
wire pcsrcD,equalD;

wire regdstE,alusrcE,mem2regE,regwriteE,flushE;
wire [2:0]alucontrolE;

wire mem2regM,regwriteM;

wire mem2regW,regwriteW;



ControlUnit CU(clk,reset,opD,funcD,flushE,equalD,mem2regE,mem2regM,mem2regW,memwriteM,pcsrcD,branchD,
alusrcE,regdstE,regwriteE,regwriteM,regwriteW,jumpD,alucontrolE,cn3,cudata);
//aluimm:ALUIMM;regdst:REGRT

DataPath DP(clk,reset,mem2regE,mem2regM,mem2regW,pcsrcD,branchD,alusrcE,regdstE,regwriteE,regwriteM,
regwriteW,jumpD,alucontrolE,equalD,pcF,instrF,aluoutM,writedataM,readdataM,opD,funcD,flushE,cn3,dpdata);

//display

    always @(*)
    begin
    case(cn2)
        2'b01: disdata = cudata;
        2'b10: disdata = dpdata;        
        default : begin
                case(cnt3)
                3'b000: disdata = pcF;
                3'b001: disdata = instrF;
                3'b010: disdata = aluoutM;
                3'b011: disdata = writedataM;
                3'b100: disdata = readdataM;
                3'b101: disdata = { {3'b000, mem2regE }, {3'b000, mem2regM },{3'b000, mem2regW }, {3'b000, branchD },  {3'b000, regwriteE }, {3'b000, regwriteM },{3'b000, regwriteW }, {1'b0, regdstE }};
                default: disdata = pcF; 
                endcase
                end 
        
    endcase
    end


endmodule
