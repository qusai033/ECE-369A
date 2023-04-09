`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2022 02:25:44 PM
// Design Name: 
// Module Name: Adder32Bit
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


module Adder32Bit(
inputA, inputB, output32
    );
    input [31:0] inputA, inputB;
    output reg [31:0] output32;
    
    always @ (*) begin
    output32 = inputA + inputB;
    end
    
    
endmodule
