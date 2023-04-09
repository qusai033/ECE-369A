// verilog InstructionFecthUnit_tb

module InstructionFetchUnit_tb(Instruction, Reset, Clk);

//Inputs
    input clk, Reset;
    //Output
    output wire [31:0] Instruction;
    
initial begin 
    forever begin
    clk = 0;
    #100 clk = ~clk;
 end end
 
initial
begin
//whatever you come up
InstructionFetchUnit(.Instruction(Instruction), .Reset(Reset), .Clk(clk));
end
 
endmodule
