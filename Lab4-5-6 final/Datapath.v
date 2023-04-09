module Top(Reset, Clock, PCout, Writeout);
 input Clock, Reset;
 output wire [31:0] PCout, Writeout;

 wire [31:0] PC[1:5], INSTR[1:3], Alpha[1:2], Beta[1:3], IMMD[1:5],
	 zeroFlag[4:4], Zer0Out, ALUDATA, WriteData;

wire Zeronot;

wire RegW[2:4], ALUsrc[2:2], PCsrc[2:4], MemR[2:3], MemW[2:3], MEM2REG[2:4], REGDST, Stall;
wire [1:0] ALUOP[2:2], Branch[2:2], MemLoad;

wire [10:0] Signals;
wire [4:0] WADDR [1:3];
wire  [31:0] ALURESULT[1:3], MEMRESULT[1:2],inp;

    /* Please fill in the implementation here... */

    /* Instruction fetch memory InstructionFetchUnit(Address, PCResult, Reset, Clk);*/
    //needs Reset
    //INPUT FROM WIRE "Dummy11", OUTPUT TO WIREs "Dummy"&"Dummy2" 
    InstructionFetchUnit IF(.Instruction(INSTR[1]), .Reset(Reset), .Clk(Clock) ,
     .Address(PC[5]), .PCR(PC[1]),.sel(PCsrc[3]), .Stall(Stall));

    /*IF/ID IF_ID(PCin, PCout, IF, ID, Clk)*/
    	IF_ID IfId(.PCin(PC[1]), .PCout(PC[2]), .IF(INSTR[1]), .ID(inp), .Clk(Clock));
    	
    	assign PCout =PC[1];
    	assign Writeout = WriteData;
    	
    	  Mux32Bit2To1 INSTRin(.out(INSTR[2]), .inA(inp), .inB(32'b0), .sel(Stall));
    	
    DECODE ID(.INSTRin(INSTR[2]), .Clock(Clock),.REGWRITE(RegW[4]),.WADDR(WADDR[3]),.WriteData(WriteData),
     .SIGNALS(Signals),  .IMMD(IMMD[1]) ,.Alpha(Alpha[1]), .Beta(Beta[1]));
    
//Hazard Detection
	HazardDetector detector(MemR[3], INSTR[2][25:21], INSTR[2][20:16], WADDR[1], Stall, 1'b0);
	
	
	//HazardDetector(MemRead_MEM,Rs_ID,Rt_ID,Rt_EX,Stall,Reset);
	
	
    /*ID_EX ID_EX(PCin, PCout, Immedin, Immedout, REG1, REG2, OPin, REG1out, REG2out, OPout, Clk)*/
    ID_EX IdEx(.PCin(PC[2]), .PCout(PC[3]), .Immedin(IMMD[1]), .Immedout(IMMD[2]),
     .REG1(Alpha[1]), .REG2(Beta[1]), .OPin(INSTR[2]),
     .REG1out(Alpha[2]), .REG2out(Beta[2]), .OPout(INSTR[3]), .Clk(Clock),
     .SIGNALSIN(Signals),
     .SIGNALS({ALUOP[2], Branch[2], RegW[2], ALUsrc[2], PCsrc[2],  MemW[2], MemR[2], MEM2REG[2], REGDST}) );
     
    /*Mux32Bit2To1(out, inA, inB, sel)*/
    
    
    EXEC EX(.INSTR(INSTR[3]), .PCin(PC[3]) , .IMMD(IMMD[2]), .Alphain(Alpha[2]), .Betain(Beta[2]), .ALUsrc(ALUsrc[2]),
     .ALUOP(ALUOP[2]),.RegDst(REGDST), .Branch(Branch[2]),.PCout(PC[4]), .ZeroFlag(zeroFlag[4]),
      .ALURESULT(ALURESULT[1]), .IMMDout(IMMD[3]), .WADDR(WADDR[1]));
    
    
    /*Ex_MEM EX_MEM(PCin, PCout,ALU, MEM, zero, OPin, ALUout, MEMout, zeroout,OPout, Clk)*/
    EX_MEM ExMem(.PCin(PC[4]), .PCout(IMMD[5]),.JUMPin({PC[3][31:28],IMMD[3][27:0]}) ,.Jump(IMMD[4]),.ALU(ALURESULT[1]),
    .MEM(Beta[2]), .Zero(zeroFlag[4]), .OPin({INSTR[3][27:26],WADDR[1],RegW[2], PCsrc[2],  MemW[2], MemR[2], MEM2REG[2]}) ,.ALUout(ALURESULT[2]),
     .MEMout(Beta[3]), .zeroout(Zer0Out),.OPout({MemLoad,WADDR[2],RegW[3], PCsrc[3],  MemW[3], MemR[3], MEM2REG[3]}), .Clk(Clock));

    /*DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, BHW,SignExt)*/ 
	MEMORY MEM(.ALURESULT(ALURESULT[2]), .Beta(Beta[3]), .Clock(Clock), 
    .MemW(MemW[3]), .MemR(MemR[3]), .PCin(IMMD[5]), .IMMD(IMMD[4]), .PCout(PC[5]),
    .MEMRESULT(MEMRESULT[1]), .sel(~Zer0Out[0]), .B(MemLoad)
    );
    /*MEM_WB(Read, Readout, ALU, ALUout, Clk)*/
	MEM_WB   MemWb(.Read(MEMRESULT[1]), .Readout(MEMRESULT[2]), .ALU(ALURESULT[2]), .ALUout(ALURESULT[3]), .Clk(Clock),
    .muxin(MEM2REG[3]), .muxout(MEM2REG[4]),.regfin(RegW[3]) ,.regfout(RegW[4]), .WADDRin(WADDR[2]), .WADDR(WADDR[3]) );

    /*Mux32Bit2To1(out, inA, inB, sel)*/
    Mux32Bit2To1 TOREG(.out(WriteData), .inA(ALURESULT[3]), .inB(MEMRESULT[2]), .sel(MEM2REG[4]));
	
    //Hazard Detection
	//HazardDetector detector(ID_EXMemRead, IF_IDInstruction[25:21], IF_IDInstruction[20:16], RegDst0, Control_Mux, IF_IDWrite, PCWrite, ID_EXRegWriteMux, RegDst1);
    
    // For FPGA Implentation: Below modules are used to output display to FPGA
    
    //Two4DigitDisplay twodigitdisplayfpga(Clk, MEMWBdisplay[15:0], Output[15:0], out7, en_out);
    
    //ClkDiv clockdividerfpga(Clk, 1'b0, Clkout);

endmodule


