module Controller(Instr, RegW, ALUsrc, ALUop, PCsrc, Branch, MemW, MemR, ToReg, RegDst);
	input [31:0] Instr;
	output reg RegW, ALUsrc, PCsrc, MemW, MemR, ToReg, RegDst;
    
    output reg [1:0] Branch, ALUop;

always @ (Instr) begin
PCsrc <= 0;
case (Instr[31:26]) 
0: begin //R-type instructions
    RegDst <= 0;
    ALUsrc <= 0;
    ToReg <= 0;
    
    if(Instr == 0)
    RegW <= 0;
    else
    RegW <= 1;
    
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 3;
    
    if (Instr[5:0] == 8)
    PCsrc <= 1;
    else 
    PCsrc <= 0;
    
   end
1: begin // BranCh
    RegDst <= 1'bx;
    ALUsrc <= 0;
    ToReg <= 1'bx;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 1;
    ALUop <= 2; //Subtract
    PCsrc <= 1;
end
2: begin // J Instruction
    RegDst <= 1'bx;
    ALUsrc <= 1'bx;
    ToReg <= 1'bx;
    RegW <= 1'bx;
    MemR <= 1'bx;
    MemW <= 1'bx;
    Branch <= 0;
    ALUop <= 1'bx; //Subtract
    PCsrc <= 1;
end
3: begin // JAL Instruction
    RegDst <= 1'bx;
    ALUsrc <= 1'bx;
    ToReg <= 1'bx;
    RegW <= 1'bx;
    MemR <= 1'bx;
    MemW <= 1'bx;
    Branch <= 0;
    ALUop <= 1'bx; //Subtract
    PCsrc <= 1;
end
4: begin //BEQ instruction
    RegDst <= 1'b0;
    ALUsrc <= 0;
    ToReg <= 1'bx;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 1;
    ALUop <= 2; //Subtract
    PCsrc <= 1;
end 
5: begin //BNE Instruction
    RegDst <= 1'b0;
    ALUsrc <= 0;
    ToReg <= 1'bx;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 2;
    ALUop <= 2; //Subtract
    PCsrc <= 1;
end 
6: begin //BLEZ Instruction
    RegDst <= 1'b0;
    ALUsrc <= 0;
    ToReg <= 1'bx;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 2;
    ALUop <= 2; //Subtract
    PCsrc <= 1;
end
7: begin //BGTZ Instruction
    RegDst <= 1'b0;
    ALUsrc <= 0;
    ToReg <= 1'bx;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 1;
    ALUop <= 2; //Subtract
    PCsrc <= 1;
end

 8: begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
 9: begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
 10: begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
 11: begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
 12: begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
 13 : begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
14 : begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
15 : begin // I-type Instructions
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end
28: begin //MUL, Mipshelper?
    RegDst <= 0;
    ALUsrc <= 0;
    ToReg <= 0;
    RegW <= 1;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0; //Add
    
end
32: begin //LB Instruction
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 1;
    RegW <= 1;
    MemR <= 1;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0; //Add
    
end
33: begin //LH Instruction
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 1;
    RegW <= 1;
    MemR <= 1;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0; //Add
    
end
35: begin //LW Instruction
    RegDst <= 1;
    ALUsrc <= 1;
    ToReg <= 1;
    RegW <= 1;
    MemR <= 1;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0; //Add
    
end
40: begin //SB Insstruction
  RegDst <= 1'bx;
    ALUsrc <= 1;
    ToReg <= 1'bX;
    RegW <= 0;
    MemR <= 0;
    MemW <= 1;
    Branch <= 0;
    ALUop <= 0; //Add
    
end
41: begin //SH Insstruction
  RegDst <= 1'bx;
    ALUsrc <= 1;
    ToReg <= 1'bX;
    RegW <= 0;
    MemR <= 0;
    MemW <= 1;
    Branch <= 0;
    ALUop <= 0; //Add
    
end

43: begin //SW Insstruction
  RegDst <= 1'bx;
    ALUsrc <= 1;
    ToReg <= 1'bX;
    RegW <= 0;
    MemR <= 0;
    MemW <= 1;
    Branch <= 0;
    ALUop <= 0; //Add
    
end

 default: begin // I-type Instructions
    RegDst <= 0;
    ALUsrc <= 0;
    ToReg <= 0;
    RegW <= 0;
    MemR <= 0;
    MemW <= 0;
    Branch <= 0;
    ALUop <= 0;
end


endcase
end





endmodule