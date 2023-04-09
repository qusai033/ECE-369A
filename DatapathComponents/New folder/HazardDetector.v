module HazardDetector(MemRead_MEM,Rs_ID,Rt_ID,Rt_EX,
Rt_MEM, Rt_WB, RegWrite_EX, RegWrite_MEM, RegWrite_WB, 
Stall, Reset, Instruction
);
	input MemRead_MEM,RegWrite_EX,RegWrite_MEM, RegWrite_WB, Reset;
	input [4:0] Rs_ID,Rt_ID,Rt_EX,Rt_MEM, Rt_WB;
	input [31:0] Instruction;
	output Stall;
	reg Stall;

	always @(MemRead_MEM,Rs_ID,Rt_ID,Rt_EX,
Rt_MEM, Rt_WB, RegWrite_EX, RegWrite_MEM, RegWrite_WB) begin
		if (Reset == 0) begin
			// LW followed by dependency
			     if
			      (MemRead_MEM == 1 && (Rs_ID == Rt_MEM || ((Rt_ID == Rt_MEM)&&Instruction[31:26] == 0))) begin // hazard detected in EXECUTION
				    Stall <= 1;
				    
			     end 
			
                else if 
                (RegWrite_EX == 1 && (Rs_ID == Rt_EX || ((Rt_ID == Rt_EX)&&Instruction[31:26] == 0))) begin // hazard detected
				    Stall <= 1;
				    
			     end 
			//Arithmetic followed by dependency
			     else if (RegWrite_EX == 1 && (Rs_ID == Rt_EX || ((Rt_ID == Rt_EX) && Instruction[31:26] == 0))) begin // hazard detected in EXECUTION
				    Stall <= 1;
				    
			     end

                else if (RegWrite_MEM == 1 && (Rs_ID == Rt_MEM ||(( Rt_ID == Rt_MEM)&& Instruction[31:26] == 0))) begin // hazard detected in MEMORY
				    Stall <= 1;
				    
			     end 

               else if (RegWrite_WB == 1 && (Rs_ID == Rt_WB || ((Rt_ID == Rt_WB)&& Instruction[31:26] == 0))) begin // hazard detected in WRITEBACK
				    Stall <= 1;
				    end 
			   else begin // hazard not detected
				    Stall <= 0;
			   end
 
		end else begin
			Stall <= 1;
		end
	end


endmodule
//module HazardDetector(MemRead_MEM,Rs_ID,Rt_ID,Rt_EX,
//Rt_MEM, Rt_WB, RegWrite_EX, RegWrite_MEM, RegWrite_WB, 
//Stall, CLK, Instruction
//);
//	input MemRead_MEM,RegWrite_EX,RegWrite_MEM, RegWrite_WB;
//	input [4:0] Rs_ID,Rt_ID,Rt_EX,Rt_MEM, Rt_WB;
//	input [31:0] Instruction;
//	output Stall;
//	reg Stall;
//	//reg [31:0] save;
//	initial begin
//	Stall <= 0;
//	end

//	always @(MemRead_MEM,Rs_ID,Rt_ID,Rt_EX,
//Rt_MEM, Rt_WB) begin
//		//if (Reset == 0) begin
		
			
			
//			     // LW followed by dependency
//			     if (MemRead_MEM == 1 && (Rs_ID == Rt_MEM || ((Rt_ID == Rt_MEM)&&Instruction[31:26] == 0))) begin // hazard detected in EXECUTION
//				    Stall <= 1;
				    
//			     end 
			
//                else if (RegWrite_EX == 1 && (Rs_ID == Rt_EX || ((Rt_ID == Rt_EX)&&Instruction[31:26] == 0))) begin // hazard detected
//				    Stall <= 1;
				    
//			     end 
//			//Arithmetic followed by dependency
//			     else if (RegWrite_EX == 1 && (Rs_ID == Rt_EX || ((Rt_ID == Rt_EX) && Instruction[31:26] == 0))) begin // hazard detected in EXECUTION
//				    Stall <= 1;
				    
//			     end

//                else if (RegWrite_MEM == 1 && (Rs_ID == Rt_MEM ||(( Rt_ID == Rt_MEM)&& Instruction[31:26] == 0))) begin // hazard detected in MEMORY
//				    Stall <= 1;
				    
//			     end 

//               else if (RegWrite_WB == 1 && (Rs_ID == Rt_WB || ((Rt_ID == Rt_WB)&& Instruction[31:26] == 0))) begin // hazard detected in WRITEBACK
//				    Stall <= 1;
				    
//			   end else begin // hazard not detected
//				    Stall <= 0;
//			   end
 
////	end else begin
////			Stall <= 1;
////		end
////	end


