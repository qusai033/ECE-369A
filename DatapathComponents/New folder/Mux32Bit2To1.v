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
		    1'b0: begin 
			    
				    out <= inA;
			   
		    end
		    
		    1'b1: begin 
			    
				    out <= inB;
			   
		    end
//		     1'bz: begin 
//			    out <= inA;
//		    end
//		    1'bx: begin 
//			    out <= inA;
//		    end
		    
	    endcase 
    end 
endmodule