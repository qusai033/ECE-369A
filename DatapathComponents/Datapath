`timescale 1ns / 1ps


module Datapath(Clk, Reset, Output);
    input Clk, Reset;
    output [31:0] Output;
    
    // Initialize wires to connect data path components
    
    wire [31:0] PCSrcMuxOut, PCOut, InstructionMemoryOut, PCAddOut, IFIDPC, IFIDInstruction,
    ReadData1, ReadData2, SignExtenOut, MemToRegMuxOut, RegWriteMuxOut;
    wire  RegWrite, ALUSrcA, ALUSrcB, Branch, MemWrite, MemRead, 
    PCSrc, RegWriteMux, HIWrite, LOWrite, SignExten;
    wire [4:0] MEMWBRegDst, ALUOp;
    wire [1:0] SControl, LControl, MemToReg, RegDst;
    
    // IDEX Register
    wire [31:0] IDEXPC, IDEXA, IDEXB, IDEXSignExten, AinALU, BinALU, destReg;
    wire IDEXRegWrite, IDEXALUSrcA, IDEXALUSrcB, IDEXBranch, IDEXMemWrite, IDEXMemRead, IDEXPCSrc, IDEXRegWriteMux, IDEXHIWrite,
    IDEXLOWrite;
    wire [4:0] IDEXALUOp, RegDst0, RegDst1, Shamt;
    wire [1:0] IDEXRegDst, IDEXSControl, IDEXLControl, IDEXMemToReg;
    wire [25:0] IDEXInstruction250;
    wire [31:0] newPC;
    
    // ALU
    wire [31:0] ALULo, ALUHi, HIin, LOin, signExten, branchAddress, jAddress;
    wire Zero;
    
    // EXMEM Register
    wire EXMEMZero, EXMEMRegWrite, EXMEMBranch, EXMEMMemWrite, EXMEMMemRead, EXMEMPCSrc,
    EXMEMRegWriteMux;
    wire [4:0] EXMEMdestReg;
    wire [1:0] EXMEMMemToReg, EXMEMSControl, EXMEMLControl;
    
    // DataMemory
    wire [31:0] ReadDataIn;
    
    // MEMWB Register
    wire [31:0] MEMWBPC, MEMWBReadData, MEMWBALULo;
    wire [1:0] MEMWBMemToReg;
    wire MEMWBZero,MEMWBRegWriteMux, MEMWBRegWrite;
    
    // debug signals
    (* mark_debug = "true" *)  wire debug_PCcontrol;
    (* mark_debug = "true" *)  wire [31:0] debug_PC;
    (* mark_debug = "true" *)  wire [31:0] debug_HI;
    (* mark_debug = "true" *)  wire [31:0] debug_LO;
    (* mark_debug = "true" *)  wire [31:0] debug_WriteData;
    
    // PCtoDisplay
    wire [31:0] IFIDdisplay;
    wire [31:0] IDEXdisplay;
    wire [31:0] EXMEMdisplay;
    wire [31:0] MEMWBdisplay;
    
    //Stage 1    
    InstructionMemory a2(PCOut, InstructionMemoryOut);
        
    //IFID
    IFIDRegister a4(PCAddOut, InstructionMemoryOut, IFIDPC, IFIDInstruction, Clk, IFIDWrite, (EXMEMPCSrc | (EXMEMBranch & EXMEMZero)), PCOut, IFIDdisplay);
    
    //Stage 2
    SignExtension a5(IFIDInstruction[15:0], SignExtenOut, SignExten);
    
    RegisterFile a6(IFIDInstruction[25:21], IFIDInstruction[20:16], MEMWBRegDst, Output, RegWriteMuxOut[0], Clk, ReadData1, ReadData2, Reset, debug_WriteData);
    
    Controller a7(IFIDInstruction, RegWrite, ALUSrcA, ALUSrcB, ALUOp, RegDst, Branch, MemWrite, MemRead, MemToReg, PCSrc, RegWriteMux, HIWrite, LOWrite,SControl, LControl, SignExten, ControlMux);
    
    //IDEX
    IDEXRegister a8(IFIDInstruction[25:0], IFIDPC, newRD1, newRD2, SignExtenOut, IFIDInstruction[20:16], IFIDInstruction[15:11],
    IFIDInstruction[10:6], RegWrite, ALUSrcA, ALUSrcB, ALUOp, RegDst, Branch, MemWrite, MemRead, MemToReg, PCSrc, RegWriteMux, HIWrite,
    LOWrite,SControl, LControl, IDEXInstruction250, IDEXPC, IDEXA, IDEXB, IDEXSignExten, RegDst0, RegDst1, Shamt, IDEXRegWrite
    , IDEXALUSrcA, IDEXALUSrcB, IDEXALUOp, IDEXRegDst, IDEXBranch, IDEXMemWrite, IDEXMemRead, IDEXMemToReg,
    IDEXPCSrc, IDEXRegWriteMux, IDEXHIWrite, IDEXLOWrite, IDEXSControl, IDEXLControl, Clk, IFIDdisplay, IDEXdisplay, (EXMEMPCSrc | (EXMEMBranch & EXMEMZero)));
    
    //Stage 3
    Mux32Bit2to1 alusrcA(AForward, {27'b0, Shamt}, AinALU, IDEXALUSrcA);
    
    Mux32Bit2to1 alusrcB(BForward, IDEXSignExten, BinALU, IDEXALUSrcB);
        
    ALU32Bit a9(IDEXALUOp, AinALU, BinALU, ALULo, ALUHi, Zero, HIin, LOin);
    

    
    //EX_MEM Register
    EX_MEM a13(jAddress, newPC, branchAddress, AinALU, Zero, ALULo, BForward, destReg[4:0], IDEXRegWrite,
    IDEXBranch, IDEXMemWrite, IDEXMemRead, IDEXMemToReg, IDEXPCSrc, IDEXRegWriteMux, IDEXSControl,
    IDEXLControl, EXMEMjAddress, EXMEMPC, EXMEMbranchAddress, EXMEMAinALU, EXMEMZero, EXMEMALULo, EXMEMB,
    EXMEMdestReg, EXMEMRegWrite, EXMEMBranch, EXMEMMemWrite, EXMEMMemRead, EXMEMMemToReg,
    EXMEMPCSrc, EXMEMRegWriteMux, EXMEMSControl, EXMEMLControl, Clk, IDEXdisplay, EXMEMdisplay, (EXMEMPCSrc | (EXMEMBranch & EXMEMZero)));
    
    //Stage 4
    DataMemory a14(EXMEMALULo, EXMEMB, Clk, EXMEMMemWrite, EXMEMMemRead, ReadDataIn, EXMEMSControl, EXMEMLControl);
        
    //MEMWB Register
    MEM_WB a15(EXMEMPC, EXMEMZero, ReadDataIn, EXMEMALULo, EXMEMdestReg, EXMEMMemToReg,
    EXMEMRegWriteMux, EXMEMRegWrite, MEMWBPC, MEMWBZero, MEMWBReadData, MEMWBALULo, MEMWBRegDst,
    MEMWBMemToReg, MEMWBRegWriteMux, MEMWBRegWrite, Clk, EXMEMdisplay, MEMWBdisplay);
    
    //Stage 5
    
    Mux32Bit2to1 regwriteMux({31'b0, MEMWBRegWrite}, {31'b0, MEMWBZero}, RegWriteMuxOut, MEMWBRegWriteMux);
    
    //Forwarding
    //Forward a17(EXMEMRegWrite, EXMEMdestReg, RegWriteMuxOut[0], MEMWBRegDst, RegDst0, IDEXInstruction250[25:21], AForwardMux, BForwardMux);
    
    //Hazard Detection
    //HazardDetection detector(IDEXMemRead, IFIDInstruction[25:21], IFIDInstruction[20:16], RegDst0, ControlMux, IFIDWrite, PCWrite, IDEXRegWriteMux, RegDst1);
    
    
    Mux32Bit2to1 WBforwardmux1(ReadData1, Output, newRD1, WBfor1);
    
    Mux32Bit2to1 WBforwardmux2(ReadData2, Output, newRD2, WBfor2);
    
    // For FPGA Implentation: Below modules are used to output display to FPGA
    
    //Two4DigitDisplay twodigitdisplayfpga(Clk, MEMWBdisplay[15:0], Output[15:0], out7, en_out);
    
    //ClkDiv clockdividerfpga(Clk, 1'b0, Clkout);
endmodule
