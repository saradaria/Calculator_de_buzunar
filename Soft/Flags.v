`timescale 1ns / 1ps

module Flags(
  input Z,N,C,O,
  output reg Z_out, N_out, C_out, O_out
);
 
 always @(*) begin
   Z_out <= Z;
   N_out <= N;
   C_out <= C;
   O_out <= O;
 end
 
endmodule
