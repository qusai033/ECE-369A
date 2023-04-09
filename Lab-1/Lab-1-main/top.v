`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2017 11:05:09 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module top(Clk, Reset, out7, en_out );
    input Clk, Reset;

    
    wire CLOCK;
    wire  [31:0] DATA;
    output [6:0] out7;
    output [7:0] en_out; 
   
  //(* mark_debug = "true" *)  wire [31:0] debug_reg;
   // RegisterFile U0(ReadRegister2, WriteRegister, WriteData, Clk, ReadData2, out_data, debug_reg);
    
    ClkDiv clock(.Clk(Clk), .Rst(Reset), .ClkOut(CLOCK));
    
    InstructionFetchUnit instruction(.Instruction(DATA), .Reset(Reset), .Clk(CLOCK));
    
    Two4DigitDisplay display(.Clk(Clk), .NumberA(DATA[31:16]), .NumberB(DATA[15:0]), .out7(out7), .en_out(en_out));
    
    
    
endmodule