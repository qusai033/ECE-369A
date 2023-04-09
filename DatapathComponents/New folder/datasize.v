module dataSize(A, B, Aout);			
	input [1:0] B;
	input [31:0] A;
	output reg [31:0 ] Aout;

    always @(*)begin
				if (B == 0) begin // Byte	
					if (A[7]==1)begin
						Aout  <= {24'hffffff , A};
					end
					else begin
						Aout <= {24'h000000, A};
					end					
				end 
				else if (B == 1) begin // Half word
					if (A[15]==1)begin
						Aout <= {16'hffff , A};
					end
					else begin
						Aout <= {16'h0000, A};
					end
				end
				else begin
						Aout <=  A;
					end
	end 				
endmodule