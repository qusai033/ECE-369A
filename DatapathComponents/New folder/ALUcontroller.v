`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2022 01:29:07 PM
// Design Name: 
// Module Name: ALUcontroller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUcontroller(ALUop,OP, func,
ALUIn, jal, jr
    );
    input [1:0] ALUop;
    input [5:0] OP, func;
    output reg [3:0] ALUIn;
    output reg jal, jr;
    
    always @ (*) begin
        jal <= 0;
        jr <= 0;
        ALUIn <= 0;
        case (ALUop)
        0: begin //I-rype instructions
            case(OP)
            0: begin //NOP 
            ALUIn <= 0;
            end
           6'h2:begin // J
              ALUIn <= 9; 
              end
           6'h3:begin // Jal
              ALUIn <= 12;
              jal <= 1;
              end
           6'ha:begin //SLTI
              ALUIn <= 7; 
              end
           6'hb:begin //
              ALUIn <= 7;
              end
            6'hC:begin  // ANDI
              ALUIn <= 0;
              end
            6'hd:begin  // orI
              ALUIn <= 1;
              end              
            6'h8:begin // Addi
              ALUIn <= 2;
              end
            6'h9:begin // 
              ALUIn <= 2;
              end
           
            6'h1c:begin //MUL
              ALUIn <= 9;
              end
           
            6'h20:begin  //lb
              ALUIn <= 2;
              end
            6'h21:begin //lh
              ALUIn<= 6;
             end  
             6'h23:begin //LW
              ALUIn <= 2; 
              end
            6'h28:begin //sb
              ALUIn <= 2;
              end
            6'h29:begin //sh
              ALUIn <= 2;
              end   
            6'h2b:begin //SW
              ALUIn <= 2;
              end
           
             endcase
        end
        2: begin// Branches
            case (OP)
            1:begin
              ALUIn <= 11; 
              end
            4:begin
              ALUIn <= 6;
              end
            5:begin  
              ALUIn <= 6;
              end
            6:begin
              ALUIn <= 7;
              end
            7:begin 
              ALUIn<=7;
              end
            endcase
        end
        3: begin
            case(func)//R-type Istructions
              0:begin //SLL
              ALUIn <= 10; 
              end
            2:begin //SRL
              ALUIn <= 13;
              end
            3:begin  // SRA
              ALUIn <= 15;
              end
            8:begin // JR
              ALUIn <= 11;
              jr <= 1;
              end
            9:begin // JAlr
              ALUIn<=12;
              end
            6'h18:begin //Mult
              ALUIn <= 9; 
              end
            6'h19:begin //
              ALUIn <= 9;
              end
            6'h20:begin  //Add
              ALUIn <= 2;
              end
            6'h21:begin
              ALUIn <= 2;
              end
            6'h22:begin //sub
              ALUIn<= 6;
              end  
           6'h23:begin
              ALUIn <= 6; 
              end
           6'h2a:begin
              ALUIn <= 7; 
              end
           6'h24:begin //AND
              ALUIn <= 0;
              end
           6'h25:begin  //ORs
              ALUIn <= 1;
              end
            6'h26:begin //XOR 
              ALUIn <= 4;
              end
            6'h27:begin //NOR
              ALUIn<=3;
              end
            
            endcase
        end
    endcase
    end
endmodule
