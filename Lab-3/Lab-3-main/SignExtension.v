`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Q Almustafa 100%
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out, SignExt);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    input SignExt;
    //reg out;
	
	always@(*) begin
		case(SignExt)
			0:begin 
				if (SignExt == 0) begin
					out <= {16'h0000 , in};
				end
			end
			1:begin 
				if (SignExt == 1) begin
					if (in[15] == 1) begin
						out <= {16'hffff , in};
					end
				end
				
				else begin
					out <= in;
				end
			end 
		endcase
	 end
endmodule
