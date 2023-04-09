module FPGATop(Clk, Reset, out7, en_out );
    input Clk, Reset;

    
    wire CLOCK;
    wire  [31:0] Writeout; 
    wire [31:0] PCout;
    output [6:0] out7;
    output [7:0] en_out; 
   
  //(* mark_debug = "true" *)  wire [31:0] debug_reg;
   // RegisterFile U0(ReadRegister2, WriteRegister, WriteData, Clk, ReadData2, out_data, debug_reg);
    
    ClkDiv clock(.Clk(Clk), .Rst(1'b0), .ClkOut(CLOCK));
    
    Top Datapath( .Reset(Reset), .Clock(CLOCK), .PCout(PCout), .Writeout(Writeout));

    
    Two4DigitDisplay display(.Clk(Clk), .NumberA(Writeout[15:0]), .NumberB(PCout[15:0]), .out7(out7), .en_out(en_out));
    
    
    
endmodule 