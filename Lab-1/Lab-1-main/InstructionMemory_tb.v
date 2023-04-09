`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	
    /* Please fill in the implementation here... */
    		
    		Address <= 8'h00000000;
    		#100;
    		
    		Address <= Address + 4;
    		#100;
    		
    		Address <= Address - 24;
    		#100;
    		
    		Address <= Address * 4;
    		#100;
    		
    		Address <= 32'b00000000110001010010100100110111;
	
	end

endmodule

