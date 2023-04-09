`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2022 04:07:54 PM
// Design Name: 
// Module Name: Top_tb
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


module FPGATop_tb();
    reg Reset, clk;
    wire [6:0] PC;
     
    initial begin
    clk <= 1'b0;
		forever #1 clk <= ~clk;
    end 
    
    initial begin
        Reset <= 1;
        #250000000;
        Reset <= 0;
    end
    FPGATop test(clk, Reset, PC );
   
    
endmodule
