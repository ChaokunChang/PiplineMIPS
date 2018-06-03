`timescale 1ns / 1ps

module Top(
	input dclk,tclk,pause,reset,
	input [13:0]CON,
	//output [31:0]writedata,dataaddr,
	output memwrite,
	output reg[7:0]en,
	output reg[6:0]dis
);
wire [31:0]writedata,dataaddr;

//display data
reg [31:0]disdata;

//dis data source
wire [1:0]cn0;
wire [5:0]imems;
wire [11:0]mems;
wire [2:0]cnt0;
wire [10:0]cn1;//**
wire [31:0]mipsdata,imemdata,memdata;
assign cn0 = CON[13:12];
assign imems = CON[11:6];
assign mems = CON[11:0];
assign cnt0 = CON[11:9];
assign cn1 = CON[11:1];//**

//mips
wire [31:0]pc,instr,readdata;
wire clk;

assign clk = tclk&(~pause);


MIPS mips(clk,reset,pc,instr,memwrite,dataaddr,writedata,readdata,cn1,mipsdata);
IMEM imem(pc[7:2],instr,imems,imemdata);
DMEM dmem(clk,memwrite,dataaddr,writedata,readdata,mems,memdata);


always @(*)
    begin
    case(cn0)
    2'b00:  begin
                case(cnt0)//12 ; 10
                3'b000: disdata = pc;
                3'b001: disdata = instr;
                3'b010: disdata = dataaddr;
                3'b011: disdata = readdata;
                3'b100: disdata = writedata;
                3'b101: disdata = { 8{ {3'b000,memwrite} } };
                default:   disdata = pc;
                endcase
            end
    
    2'b01: disdata = mipsdata;
    2'b10: disdata = imemdata;
    2'b11: disdata = memdata;
    endcase
    
    end

//DataDis module
wire [6:0]dis1,dis2,dis3,dis4,dis5,dis6,dis7,dis8;
reg  [2:0]q=0;
    
    sex7 s1(disdata[3:0],dis1);
    sex7 s2(disdata[7:4],dis2);
    sex7 s3(disdata[11:8],dis3);
    sex7 s4(disdata[15:12],dis4);
    sex7 s5(disdata[19:16],dis5);
    sex7 s6(disdata[23:20],dis6);
    sex7 s7(disdata[27:24],dis7);
    sex7 s8(disdata[31:28],dis8);
    
    always @(posedge dclk)
    begin
    q <= q+1;
    case(q)
        3'b000: begin en <= 8'b11111110; dis <= dis1; end
        3'b001: begin en <= 8'b11111101; dis <= dis2; end
        3'b010: begin en <= 8'b11111011; dis <= dis3; end
        3'b011: begin en <= 8'b11110111; dis <= dis4; end
        3'b100: begin en <= 8'b11101111; dis <= dis5; end
        3'b101: begin en <= 8'b11011111; dis <= dis6; end
        3'b110: begin en <= 8'b10111111; dis <= dis7; end
        3'b111: begin en <= 8'b01111111; dis <= dis8; end
    endcase
    end



endmodule
