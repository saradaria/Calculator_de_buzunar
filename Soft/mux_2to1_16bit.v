`timescale 1ns / 1ps

module mux_2to1_16bit(
    input   [15:0] a, b,
    input          sel,
    output reg [15:0] out
);

  
	 always @(*) begin
    if (sel == 0) begin
	     out <= a;
	  end
	  else begin
       out <= b;
	  end
	 end
	
endmodule
