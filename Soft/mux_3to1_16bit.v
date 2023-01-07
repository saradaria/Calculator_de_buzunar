`timescale 1ns / 1ps

module mux_3to1_16bit (
   input [15:0] a, b, c,
   input  [1:0] sel,
   output reg [15:0] out
);

  always @(*) begin
      if (sel == 2'b00) begin  //Imm
         out <= a;
      end
      else if (sel == 2'b01) begin  //ACC
         out <= b;
      end
      else if (sel == 2'b10) begin  //Dout
         out <= c;
      end
  end
  
endmodule
