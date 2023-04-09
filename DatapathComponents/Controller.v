`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////////////
//
// Qusai 100%
// Controller.v
//
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////

module Controller(Instruction, RegWrite, ALUSrcA, ALUSrcB, ALUOp, RegDst, Branch, MemWrite, MemRead, 
                  MemToReg, PCSrc, RegWriteMux, HIWrite, LOWrite,SControl, LControl, SignExten, control);
    input [31:0] Instruction;
    input control;
    output reg RegWrite, ALUSrcA, ALUSrcB, Branch, MemWrite, MemRead, PCSrc;
    output reg RegWriteMux, HIWrite, LOWrite, SignExten;
    output reg [1:0] MemToReg, LControl, SControl, RegDst;
    output reg[4:0] ALUOp;
    
    
    always @(*) begin
        RegWrite <= 1'b0;
        ALUSrcA <= 1'b0;
        ALUSrcB <= 1'b0;
        ALUOp <= 5'b0;
        RegDst <= 2'b00;
        Branch <= 1'b0;
        MemWrite <= 1'b0;
        MemRead <= 1'b0;
        PCSrc <= 1'b0;
        RegWriteMux <= 1'b0;
        HIWrite <= 1'b0;
        LOWrite <= 1'b0; 
        SignExten <= 1'b0;
        MemToReg <= 2'b00;
        LControl <= 2'b00;
        SControl <= 2'b00;
        
        if(control == 1'b1)begin
            end
        else begin
            if(Instruction[31:26] == 6'b000000)begin
                //add signed 
                if(Instruction[5:0] == 6'b100000)begin
                    RegWrite <= 1'b1;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //add unsigned---> addu
                if(Instruction[5:0] == 6'b100001)begin
                    RegWrite <= 1'b1;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //sub
                if(Instruction[5:0] == 6'b100010)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00001;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //mult singed---> mult
                if(Instruction[5:0] == 6'b011000)begin
                    ALUOp <= 5'b01000;
                    HIWrite <= 1'b1;
                    LOWrite <= 1'b1;
                end
                
                //mult unsinged----> multu
                if(Instruction[5:0] == 6'b011001)begin
                    ALUOp <= 5'b01001;
                    HIWrite <= 1'b1;
                    LOWrite <= 1'b1;
                end
                
                //jump-----> j
                if(Instruction[5:0] == 6'b001000)begin
                    PCSrc <= 1'b1;
                end
                
                //and
                if(Instruction[5:0] == 6'b100100)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00011;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //or
                if(Instruction[5:0] == 6'b100101)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00100;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //not or----> nor
                if(Instruction[5:0] == 6'b100111)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b10000;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //exclusive or-----> xor
                if(Instruction[5:0] == 6'b100110)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b10001;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //shift left logic----->sll
                if(Instruction[5:0] == 6'b000000)begin
                    RegWrite <= 1'b1;
                    ALUSrcA <= 1'b1;
                    ALUOp <= 5'b01010;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //shift rright logic ----> srl , Rotate Word Right---> rotr 
                if(Instruction[5:0] == 6'b000010)begin
                    RegWrite <= 1'b1;
                    ALUSrcA <= 1'b1;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                    if(Instruction[21] == 1'b0)begin
                        ALUOp <= 5'b01011;
                    end
                    
                    if(Instruction[21] == 1'b1)begin
                        ALUOp <= 5'b10100;
                    end
                end
                
                //Shift Word Left Logical Variable----> sllv
                if(Instruction[5:0] == 6'b000100)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b01010;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                // Shift Word Right Logical Variable----> srlv, Rotate Word Right Variable-----> rotrv
                if(Instruction[5:0] == 6'b000110)begin
                    RegWrite <= 1'b1;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                        if(Instruction[6] == 1'b0)begin
                            ALUOp <= 5'b01011;
                        end
                        if(Instruction[6] == 1'b1)begin
                            ALUOp <= 5'b10100;
                        end
                end
                
                //set on less than ----> slt
                if(Instruction[5:0] == 6'b101010)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00101;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Move Conditional on Not Zero----> movn
                if(Instruction[5:0] == 6'b001011)begin
                    ALUOp <= 5'b10010;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                    RegWriteMux <= 1'b1;
                end
                
                //movz-----> Move Conditional on Zero
                if(Instruction[5:0] == 6'b001010)begin
                    ALUOp <= 5'b10011;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                    RegWriteMux <= 1'b1;
                end
                
                //Shift Word Right Arithmetic -----> sra
                if(Instruction[5:0] == 6'b000011)begin
                    RegWrite <= 1'b1;
                    ALUSrcA <= 1'b1;
                    ALUOp <= 5'b10101;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Shift Word Right Arithmetic Variable -----> srav
                if(Instruction[5:0] == 6'b000111)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b10101;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Set on Less Than Unsigned----> sltu
                if(Instruction[5:0] == 6'b101011)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00110;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Move To HI Register -----> mthi
                if(Instruction[5:0] == 6'b010001)begin
                    ALUOp <= 5'b11001;
                    HIWrite <= 1'b1;
                end
                
                //Move To LO Register -----> mtlo
                if(Instruction[5:0] == 6'b010011)begin
                    ALUOp <= 5'b11010;
                    LOWrite <= 1'b1;
                end
                
                //Move From HI Register ----> mfhi
                if(Instruction[5:0] == 6'b010000)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b11011;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Move From LO Register ----> mflo
                if(Instruction[5:0] == 6'b010010)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b11100;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
        
            end
            
            if(Instruction[31:26] == 6'b011100)begin
            
                //Multiply Word to GPR ---- > mul
                if(Instruction[5:0] == 6'b000010)begin
                    RegWrite <= 1'b1;
                    ALUOp <= 5'b00010;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                end
                
                //Multiply and Add Word to Hi, Lo ----> madd
                if(Instruction[5:0] == 6'b000000)begin
                    ALUOp <= 5'b10111;
                    HIWrite <= 1'b1;
                    LOWrite <= 1'b1;
                end
                
                //Multiply and Subtract Word to Hi, Lo -----> msub
                if(Instruction[5:0] == 6'b000100)begin
                    ALUOp <= 5'b11000;
                    HIWrite <= 1'b1;
                    LOWrite <= 1'b1;
                end
            end
            
            if(Instruction[31:26] == 6'b011111)begin
                //Sign-Extend Halfword ---> seh, Sign-Extend Byte----->seb
                if(Instruction[5:0] == 6'b100000)begin
                    RegWrite <= 1'b1;
                    RegDst <= 2'b01;
                    MemToReg <= 2'b01;
                  
                    if(Instruction[10:6] == 5'b10000)begin
                        ALUOp <= 5'b11110;
                    end
                  
                    if(Instruction[10:6] == 5'b11000)begin
                        ALUOp <= 5'b11111;
                    end
                end
            end
            
            //Add Immediate Unsigned Word -----> addiu
            if(Instruction[31:26] == 6'b001001)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; MemToReg <= 2'b01;
            end
            
            //Add Immediate Word -----> addi
            if(Instruction[31:26] == 6'b001000)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; MemToReg <= 2'b01;
            end
            
            // load Word ----> lw
            if(Instruction[31:26] == 6'b100011)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; MemRead <= 1'b1;
            end
            
            //Store Word ----> sw
            if(Instruction[31:26] == 6'b101011)begin
                ALUSrcB <= 1'b1; MemWrite <= 1'b1; SControl <= 2'b00;
            end
            
            //Store Byte ----> sb
            if(Instruction[31:26] == 6'b101000)begin
                ALUSrcB <= 1'b1; MemWrite <= 1'b1; SControl <= 2'b10;
            end
            
            // load hlaf  ---> lh
            if(Instruction[31:26] == 6'b100001)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; MemRead <= 1'b1; LControl <= 2'b11;
            end
            
            //load byte ----> lb
            if(Instruction[31:26] == 6'b100000)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; MemRead <= 1'b1; LControl <= 2'b10;
            end
            
            //Store half -----> sh
            if(Instruction[31:26] == 6'b101001)begin
                ALUSrcB <= 1'b1; MemWrite <= 1'b1; SControl <= 2'b11;
            end
            
            //Load Upper Immediate -----> lui
            if(Instruction[31:26] == 6'b001111)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b11101; MemToReg <= 2'b01;
            end
            
            //Branch on Greater Than or Equal to Zero ------> bgez, Branch on Less Than Zero -----> bltz
            if(Instruction[31:26] == 6'b000001)begin
                Branch <= 1'b1; 
                if(Instruction[20:16] == 5'b00001)begin
                    ALUOp <= 5'b01100;
                end
                if(Instruction[20:16] == 5'b00000)begin
                    ALUOp <= 5'b01111;
                end
            end
            
            //Branch on Equal -----> beq
            if(Instruction[31:26] == 6'b000100)begin
                ALUOp <= 5'b00001; Branch <= 1'b1; 
            end
            
            //Branch on Not Equal -----> bne
            if(Instruction[31:26] == 6'b000101)begin
                ALUOp <= 5'b00111; Branch <= 1'b1; 
            end
            
            //Branch on Greater Than Zero ----> bgtz
            if(Instruction[31:26] == 6'b000111)begin
                ALUOp <= 5'b01101; Branch <= 1'b1; 
            end
            
            //Branch on Less Than or Equal to Zero -----> blez
            if(Instruction[31:26] == 6'b000110)begin
                ALUOp <= 5'b01110; Branch <= 1'b1; 
            end
            
            //jump
            if(Instruction[31:26] == 6'b000010)begin
                ALUOp <= 5'b10110; Branch <= 1'b1; PCSrc <= 1'b1;
            end
            
            //Jump and Link -----> jal
            if(Instruction[31:26] == 6'b000011)begin
                RegWrite <= 1'b1; ALUOp <= 5'b10110; Branch <= 1'b1; RegDst <= 2'b10; MemToReg <= 2'b10; PCSrc <= 1'b1; 
            end
            
            // add Immediate -----> andi
            if(Instruction[31:26] == 6'b001100)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b00011; MemToReg <= 2'b01; SignExten <= 1'b1;
            end
            
            //Or Immediate -----> ori
            if(Instruction[31:26] == 6'b001101)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b00100; MemToReg <= 2'b01; SignExten <= 1'b1;
            end
            
            //Exclusive Or Immediate ----> xori
            if(Instruction[31:26] == 6'b001110)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b10001; MemToReg <= 2'b01; SignExten <= 1'b1;
            end
            
            //Set on Less Than Immediate signed ----- > slti
            if(Instruction[31:26] == 6'b001010)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b00101; MemToReg <= 2'b01;
            end
            
            //Set on Less Than Immediate Unsigned ----> sltiu
            if(Instruction[31:26] == 6'b001011)begin
                RegWrite <= 1'b1; ALUSrcB <= 1'b1; ALUOp <= 5'b00110; MemToReg <= 2'b01;
            end
        end
    end
endmodule
