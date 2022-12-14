`timescale 1ns / 1ps

module PC(
  input clk, reset, 
  input [15:0] PC_in,
  output reg [15:0] PC_out
  );
	
	// Behavioral section for writing to the register 
always @ ( posedge clk or posedge reset ) begin
	if (reset) 
		PC_out <= 16'b0; 
	else 
		PC_out <= PC_in; 
end	

endmodule
