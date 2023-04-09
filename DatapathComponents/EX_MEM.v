`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Qusai Almustafa 65%, Jasiah Joseph 35%
// 
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

module EX_MEM(PCin, PCout,ALU, MEM, zero, OPin, ALUout, MEMout, zeroout,OPout, Clk);

	input [31:0] PCin, ALU,MEM,Zero,OPin;
	input Clk;
	
	output reg [31:0] PCout,ALUout,MEMout,zeroout,OPout;
	
	reg [31:0] Registers [0:4];
	
	initial begin
		Registers[0] <= 8'h00000000;
		Registers[8] <= 8'h00000000;
		Registers[16] <= 8'h00000000;
		Registers[20] <= 8'h00000000;
		Registers[24] <= 8'h00000000;
	
	
	end
	
	
	always @(posedge Clk)begin
			Registers[0] <= PCin;
			Registers[8] <= OPin;
			Registers[16] <= ALU;
			Registers[20] <= MEM;
			Registers[24] <= zero;
		end
	end
	
	always @(negedge Clk)begin
		PCout <= Registers[0];
		OPout <= Registers[8];
		ALUout <= Registers[16];
		MEMout <= Registers[20];
		zeroout	<= Registers[24];
	end
endmodule
