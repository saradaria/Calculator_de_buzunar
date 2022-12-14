`timescale 1ns / 1ps

module Sign_Extend(
  input [9:0] imm,
  output [15:0] imm_extend
  );
  
 assign imm_extend ={6'b0, imm};
 
endmodule
