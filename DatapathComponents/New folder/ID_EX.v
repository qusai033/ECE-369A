`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Qusai Almustafa 90%
// Jasiah Joseph 10%
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module ID_EX(PCin, PCout, Immedin, Immedout, REG1, REG2, OPin, REG1out, REG2out, OPout, Clk, SIGNALSIN, SIGNALS);

	input [31:0] PCin,Immedin,REG1,REG2,OPin;
	input Clk;
	input [10:0] SIGNALSIN;
	output reg [31:0] PCout,Immedout,REG1out,REG2out,OPout;
	output reg [10:0] SIGNALS;
	reg [31:0] Registers [0:4];
	reg [10:0] Signs;
	initial begin
		Registers[0] <= 8'h00000000;
		Registers[1] <= 8'h00000000;
		Registers[2] <= 8'h00000000;
		Registers[3] <= 8'h00000000;
		Registers[4] <= 8'h00000000;
	Signs <= 0;
	
	end
	
	
	always @(*)begin
			Registers[0] <= PCin;
			Registers[1] <= OPin;
			Registers[2] <= Immedin;
			Registers[3] <= REG1;
			Registers[4] <= REG2;
			Signs <= SIGNALSIN;
		end
	
	
	always @(posedge Clk)begin
		PCout <= Registers[0];
		OPout <= Registers[1];
		Immedout <= Registers[2];
		REG1out <= Registers[3];
		REG2out	<= Registers[4];
		SIGNALS <= Signs;
	end
endmodule