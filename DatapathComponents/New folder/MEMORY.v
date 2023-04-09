`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 12:24:15 PM
// Design Name: 
// Module Name: MEMORY
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


module MEMORY(ALURESULT, Beta, Clock, 
MemW, MemR, PCin, IMMD, PCout, MEMRESULT, sel, B
    );
    
    input [31:0] ALURESULT, Beta, PCin, IMMD;
    input Clock, sel, MemW, MemR; 
    input [1:0] B;
    
    wire [31:0] writedata, readdata;
    
    
    output  wire [31:0] MEMRESULT, PCout; 
    
    dataSize inp(Beta, B, writedata);
    
    DataMemory Mem(.Address(ALURESULT), .WriteData(writedata), .Clk(Clock),
     .MemWrite(MemW), .MemRead(MemR), .ReadData(readdata));
	 
	// Mux32Bit2To1 branch(.out(), .inA(Dummy11), .inB(Dummy18), .sel());
    dataSize out(readdata, B, MEMRESULT);

    Mux32Bit2To1  toPC(.out(PCout), .inA(PCin), .inB(IMMD), .sel(sel));

endmodule
