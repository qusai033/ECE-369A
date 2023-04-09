`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module.  
// You need to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Reset, Clk, Stall);

	input [31:0] Address;
	input Reset, Clk, Stall;

	output  [31:0] PCResult;
	reg [31:0] PCResult;
	
	
	initial begin
	   PCResult <= 32'b00000000000000000000000000000000;
	end

    /* Please fill in the implementation here... */
    always@(posedge Clk
   // , Stall
   )
     begin
        
            if (Reset) begin 
	           PCResult <= 32'b00000000000000000000000000000000;
               end
             else if(Stall == 1'b0)begin
                PCResult <= Address;
             end
	    else begin
	       PCResult <= Address - 32'b00000000000000000000000000001000; 
	    end
    end
endmodule

