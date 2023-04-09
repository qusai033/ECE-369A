`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//  Q Almustafa 100%
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, BHW,SignExt); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk, SignExt;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [1:0] BHW;

    output reg[31:0] ReadData; // Contents of memory location at Address
    reg[31:0] Memory[0:63];	// stack pointer initialization depends on this

	//initial begin
	//$readmemh(" ",Memory);
	//end
	always 	@(posedge Clk) begin  //Memory write
		if (MemWrite==1) begin
			case (BHW)
				0: begin
					case (Address[1:0])
						0: Memory[Address>>2] = {Memory[Address>>2][31:8],WriteData[7:0]};
						1: Memory[Address>>2] = {Memory[Address>>2][31:16],WriteData[7:0],Memory[Address>>2][7:0]};
						2: Memory[Address>>2] = {Memory[Address>>2][31:24],WriteData[7:0],Memory[Address>>2][15:0]};
						3: Memory[Address>>2] = {WriteData[7:0],Memory[Address>>2][23:0]};
					endcase
				end
				1: begin
					case (Address[1])
						0: Memory[Address>>2] = {Memory[Address>>2][31:16],WriteData[15:0]};
						1: Memory[Address>>2] = {WriteData[15:0],Memory[Address>>2][15:0]};
					endcase
				end
				2: begin 
					Memory[Address>>2] = WriteData;
				end
			endcase // Memory[Address>>2] = WriteData;
		end
   	end
	
	always @(Address or MemRead)begin	
   			if(MemRead == 1)begin
				case (BHW)
					0: begin // BYTE
						case (Address[1:0]) // 31:24,23:16,15:8,7:0
							0: begin
								if (SignExt && Memory[Address>>2][7])
									ReadData <= {24'hffffff,Memory[Address>>2][7:0]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][7:0]};
							end
							1: begin
								if (SignExt && Memory[Address>>2][15])
									ReadData <= {24'hffffff,Memory[Address>>2][15:8]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][15:8]};
							end
							2: begin
								if (SignExt && Memory[Address>>2][23])
									ReadData <= {24'hffffff,Memory[Address>>2][23:16]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][23:16]};
							end
							3: begin
								if (SignExt && Memory[Address>>2][31])
									ReadData <= {24'hffffff,Memory[Address>>2][31:24]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][31:24]};
							end
						endcase
					end
					1: begin // HALFWORD
						case (Address[1])
							0: begin
								if (SignExt && Memory[Address>>2][15])
									ReadData <= {16'hffff,Memory[Address>>2][15:0]};
								else 
									ReadData <= {16'b0,Memory[Address>>2][15:0]};
							end	
							1: begin
								if (SignExt && Memory[Address>>2][31])
									ReadData <= {16'hffff,Memory[Address>>2][31:16]};
								else 
									ReadData <= {16'b0,Memory[Address>>2][31:16]};
							end
						endcase
					end
					2: begin // WORD
						ReadData <= Memory[Address>>2];
					end
				endcase
   			end 
		else 
   				ReadData <= 32'h00000000; //$display("%h",Memory[Address]);
   		end
	end
endmodule
