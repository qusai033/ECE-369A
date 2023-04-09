`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
		forever display("Address : Read data, %d : %d", Address, ReadData);
	end

	initial begin
	
    /* Please fill in the implementation here... */
		MemWrite <= 0;
		MemRead <= 0;
		Address <= 32'hadfadec2x;
		WriteData <= 32'h0000000fx;
		#25 MemWrite <= 1;
		#25 MemRead <= 1;
		#25 Address <= 0;
		
	end

endmodule
