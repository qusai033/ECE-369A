`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile_tb.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();
	reg [31:0] Ip1;
	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;

 // Instantiate the Unit Under Test (UUT)

 RegisterFile RegFile(.ReadRegister1(ReadRegister1), .ReadRegister2(ReadRegister2), .WriteRegister(WriteRegister), 
		      .WriteData(WriteData), .RegWrite(RegWrite), .Clk(Clk), .ReadData1(ReadData1), .ReadData2(ReadData2));
    	initial begin
		Clk <= 1'b0;
	  // Wait 100 ns for global reset to finish

         #100;     
		forever #10 Clk <= ~Clk;
	end
	initial begin

  // Initialize Inputs

  ReadRegister1 = 5'b0;
  ReadRegister2 = 5'b0;
  WriteRegister = 5'b0;
  

  RegWrite  = 1'b0;

  // rst  = 1'b1;

  // Wait 100 ns for global reset to finish

  #100;     

   

  // Add stimulus here
  

   #20;
   
   RegWrite  = 1'b1;

   

   Ip1  = 32'habcd_efab;

  ReadRegister1 = Ip1[15:11];
  ReadRegister2 = Ip1[20:16];
  WriteRegister = Ip1[25:21];
  WriteData = Ip1;
   #10 ReadRegister1 = Ip1[25:21];
    
   #20;

   Ip1  = 32'h0123_4567;

  ReadRegister1 = Ip1[15:11];
  ReadRegister2 = Ip1[20:16];
  WriteRegister = Ip1[25:21];
  WriteData = Ip1;
    #10 ReadRegister1 = Ip1[25:21];
   #20;
   RegWrite  = 1'b0;

  ReadRegister1 = Ip1[20:16];
  ReadRegister2 = Ip1[15:11];
  WriteRegister = Ip1[25:21];
  WriteData = Ip1;
  #10 ReadRegister1 = Ip1[25:21];
 end 



endmodule