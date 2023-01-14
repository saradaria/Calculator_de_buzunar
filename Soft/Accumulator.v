`timescale 1ns / 1ps

module Accumulator(
  input [15:0] alu_out,
  input ACC_out,
  output reg[15:0] out
);
 
 always @(*) begin
   if (ACC_out) begin
     out <= alu_out;
   end
 end
 
endmodule
