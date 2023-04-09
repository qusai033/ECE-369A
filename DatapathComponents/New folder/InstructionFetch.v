
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members:
// Overall percent effort of each team meber: 
// 
// ECE369A - Computer Architecture
// Laboratory 3 (PostLab)
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed 
//
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

//need to make testbench with reset and clock

module InstructionFetchUnit(Instruction, Reset, Clk, Address , PCR, sel, Stall);

    /* Please fill in the implementation here... */
    
    //Inputs
    input Clk, Reset, sel, Stall;
    input [31:0] Address;
    //Output
    output [31:0] Instruction;
    
    //Wires Address, PCResult
    output wire [31:0] PCR;
    wire [31:0] address, addrmux;
    
    Mux32Bit2To1 mux( addrmux, address, Address, sel);
    
    //Call PCAdder(PCResult, PCAddResult)
    PCAdder Adder (.PCResult(addrmux), .PCAddResult(PCR));
    
    //wire to programCounter-- PCAddResult ==>Address
    
    //call ProgramCounter(Address, PCResult, Reset, Clk)
    ProgramCounter PC (.Address(PCR), .PCResult(address), .Reset(Reset), .Clk(Clk), .Stall(Stall));
    
    //Wire to instruction and PCadder -- PCResult ==>PCResult & PCResult ==>Address
        //Call InstructionMemory(Address, Instruction)
    InstructionMemory IM (.Address(address), .Instruction(Instruction));
    
   
    
endmodule
