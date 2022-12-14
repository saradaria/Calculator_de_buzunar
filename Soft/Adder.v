`timescale 1ns / 1ps

module Adder(
    input   [15:0] a,b,
    output reg [15:0] out
);

  
 always @(*) begin
   out <= a + b;
 end
	
endmodule