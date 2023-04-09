`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//  Q Almustafa 100%
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input sel;
	
	always@(*)begin
	    case(sel)
		    0: begin 
			    if (sel == 0)begin
				    out <= inA;
			    end
		    end
		    
		    1: begin 
			    if (sel == 1 )begin
				    out <= inB;
			    end
		    end
	    endcase 
    end 
endmodule
