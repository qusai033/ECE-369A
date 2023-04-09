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

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
	integer temp,i,x;
	reg [31:0] y;
	reg sign;
	
	
	always @(ALUControl,A,B)begin
		case (ALUControl)
			0: begin // AND
				ALUResult <= A & B;
			end
			1: begin // OR
				ALUResult <= A | B;
			end
			2: begin // ADD
				ALUResult <= A + B;
			end 
			6: begin // SUB
				ALUResult <= A + (~B + 1);
			end
			7: begin // SLT
				if (A[31] != B[31]) begin
					if (A[31] > B[31]) begin
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
			3: begin // NOR
				ALUResult <= ~(A | B); 
			end
			8: begin end // unoccupied
			9: begin // multp
				ALUResult <= A * B;
			end 
			10: begin // SLL
				ALUResult <= A << (B);
			end
			11: begin // SGT - Set Greater Than
				if (A[31] != B[31]) begin
					if (A[31] > B[31]) begin
						ALUResult <= 0;
					end 
					else begin
						ALUResult <= 1;
					end
				end 
				else begin
					if (A <= B)begin
						ALUResult <= 0;
					end
					else begin
						ALUResult <= 1;
					end
				end
			end
			12: begin // CLO/CLZ
				x = B;
				temp = 32;
				i = 31;
				while ( i >= 0) begin
					if (A[i] == x) begin
						temp = 31 - i;
						i = -2;
					end
					i -= 1;
				end
				ALUResult <= temp;
			end
			13: begin // ROTR & SRL
				y = A;
				i = B[4:0];
				while (i > 0) begin
					if (B[5] == 1) begin
						y = {y[0],y[31:1]};
					end
					else begin
						y = {1'b0,y[31:1]};
					end
					i -= 1
				end
				ALUResult <= y;
			end
			4: begin // XOR
				ALUResult <= A^B;
			end
			14: begin // SLTU
				ALUResult <= A < B;
			end
			5: begin // Sign Extension
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
			15: begin // SRA
				y = A;
				i = B;
				for ( i > 0) begin
					y = {y[31],y[31:1]};
					i -= 1;
				end
				ALUResult <= y;
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

