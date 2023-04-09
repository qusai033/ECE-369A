`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Q Almustafa 100%
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, pc, Shamt);

	input [3:0] ALUControl; // control bits for ALU operation
    input [4:0] Shamt;                            // you need to adjust the bitwidth as needed
	input [31:0] A, B, pc;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

	
	
	always @(*)begin
	   ALUResult <= 0; 
		case (ALUControl)
			4'b0000: begin // AND
				ALUResult <= A & B;
			end
			4'b0001: begin // OR
				ALUResult <= A | B;
			end
			4'b0010: begin // ADD
				ALUResult <= A + B;
			end 
			4'b0011: begin // NOR
				ALUResult <= ~(A | B); 
			end
			4'b0100: begin // XOR
				ALUResult <= A^B;
			end
			4'b0101: begin // Sign Extension
				if (B == 0) begin // Byte	
					if (A[7]==1)begin
						ALUResult  <= {24'hffffff , A};
					end
					else begin
						ALUResult <= A;
					end					
				end 
				else if (B == 1) begin // Half word
					if (A[15]==1)begin
						ALUResult <= {16'hffff , A};
					end
					else begin
						ALUResult <= A;
					end
				end					
			end
			4'b0110: begin // SUB
				ALUResult <= A - B;
			end
			4'b0111: begin // SLT
				if (A[31] != B[31]) begin
					if (A[31] > B[31]) begin
						ALUResult <= 1;
					end 
					else begin
						ALUResult <= 0;
					end
				end 
				else begin
					if (A <= B)begin
						ALUResult <= 1;
					end
					else begin
						ALUResult <= 0;
					end
				end
			end
			
			4'b1000: begin //Set on Not Equal
			ALUResult <= A === B;
			end 
			4'b1001: begin // multp
				ALUResult <= A * B;
			end 
			4'b1010: begin // SLL
				ALUResult <= B << Shamt;
			end
			4'b1011: begin // SGT - Set on Greater Than
				if (B != 1) begin
					if (A >-1) begin
						ALUResult <= 1;
					end 
					else begin
						ALUResult <= 0;
					end
				end 
				else begin
					if (A < B)begin
						ALUResult <= 1;
					end
					else begin
						ALUResult <= 0;
					end
				end
			end
	       4'b1100: begin 
	           ALUResult <= pc ;
			end
			4'b1101: begin // SRL			
				ALUResult <= B >> Shamt;
			end
			
			4'b1110:begin 
			end
			
			4'b1111: begin // SRA		
				ALUResult <= B >>> Shamt;
			end
			
		
		endcase
	end


	always @(ALUResult) begin
		if (ALUResult == 0) begin
			Zero <= 1;
		end 
		else begin
			Zero <= 0;
		end
	end
endmodule
