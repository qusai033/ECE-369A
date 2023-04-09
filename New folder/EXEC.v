module EXEC(INSTR, PCin , IMMD, Alphain, Betain,
ALUsrc, ALUOP, Branch, RegDst,
PCout, ZeroFlag, ALURESULT, IMMDout, WADDR);

input [31:0] IMMD, Alphain, Betain, INSTR, PCin;
input ALUsrc, RegDst; 
input [1:0] ALUOP, Branch;
output wire [31:0] ZeroFlag, PCout, ALURESULT, IMMDout ;
output wire [4:0]  WADDR;

wire [31:0] ALUDATA , IMMD2, IN;

wire jal, addy,jr;

wire [3:0] ALUin, Addy;
wire zeroFlag[1:3];

  // INPUT FROM CONTROLLER
    //Mux32Bit2To1(out, inA, inB, sel);
    // INPUT FROM CONTROLLER
    	Mux32Bit2To1 ALUSRC(.out(ALUDATA), .inA(Betain), .inB(IMMD), .sel(ALUsrc));    
        Mux32Bit2To1 Dst({addy, Addy}, INSTR[15:11],INSTR[20:16],RegDst);
        Mux32Bit2To1 Jal(WADDR, {addy, Addy}, 32'b0000000000011111,jal);

        
    /*ALU32Bit(ALUControl, A, B, ALUResult, Zero)*/ 
    //INPUT FORM CONTROLLER
     ALUcontroller ALUC(.ALUop(ALUOP),.OP(INSTR[31:26]), .func(INSTR[5:0]), .ALUIn(ALUin), .jal(jal), .jr(jr));
    
    ALU32Bit Alu(.ALUControl(ALUin), .A(Alphain), .B(ALUDATA), .ALUResult(ALURESULT), 
    .Zero(zeroFlag[1]), .pc(PCin), .Shamt(INSTR[10:6]));
    
    
    Shifter toBranch(IMMD, IMMD2);
    Mux32Bit2To1 jumpreg(IN, INSTR[25:0],INSTR[25:21],jr);
    Shifter toJump({6'b000000,IN}, IMMDout);
    
    Adder32Bit pc(IMMD2,PCin,PCout);
    
    assign zeroFlag[2] = zeroFlag[1] & Branch[0];
    not(Zeronot,zeroFlag[1]);
    assign zeroFlag[3] = Zeronot & Branch[1];
    assign ZeroFlag[0] = zeroFlag[2] | zeroFlag[3];
    assign ZeroFlag[31:1] = 0;


endmodule