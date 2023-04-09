   module DECODE(INSTRin, Clock,REGWRITE, WADDR, WriteData, SIGNALS, IMMD ,Alpha, Beta);
   
   input REGWRITE, Clock;
   input [4:0] WADDR;
   input [31:0] INSTRin, WriteData;
   output wire [31:0]  Alpha, Beta, IMMD;
   output wire [10:0] SIGNALS;
   
   wire RegW, ALUsrc, PCsrc, MemW, MemR, MEM2REG, REGDST;
   wire [1:0] ALUOP, Branch;
  	
   
     /* Controller */ 
    Controller control(.Instr(INSTRin), .RegW(RegW), .ALUsrc(ALUsrc), .ALUop(ALUOP), .PCsrc(PCsrc),
     .Branch(Branch), .MemW(MemW), .MemR(MemR), .ToReg(MEM2REG), .RegDst(REGDST));

    /*Register file RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2)*/
	//Needs Reset
	RegisterFile RegFile(.ReadRegister1(INSTRin[25:21]), .ReadRegister2(INSTRin[20:16]),
	 .WriteRegister(WADDR), .WriteData(WriteData), .RegWrite(REGWRITE), .Clk(Clock),
	  .ReadData1(Alpha), .ReadData2(Beta));
	
    /*Sign Extension unit     SignExtension(in, out, SignExt)*/
	SignExtension  Sign(.in(INSTRin[15:0]), .out(IMMD));
   
   assign SIGNALS = {ALUOP, Branch, RegW, ALUsrc, PCsrc,  MemW, MemR, MEM2REG, REGDST};
   
endmodule
