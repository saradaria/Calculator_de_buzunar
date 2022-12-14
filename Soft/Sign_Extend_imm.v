`timescale 1ns / 1ps

module Sign_Extend_imm(
  input [8:0] imm,
  output reg [15:0] imm_extend
  );
 
  always@(imm)
	 begin
		if (imm[8]==1)
			begin
			  imm_extend <= {1'b1, 6'b0 , imm};
			end
			else 
			begin
			  imm_extend <= {7'b0, imm};
			end	
	 end  
endmodule
