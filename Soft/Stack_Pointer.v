`timescale 1ns / 1ps

module Stack_Pointer(
  input pop, psh,
  output reg [15:0] data_out
  );
 
 //adresa unde dam push si pop
 reg [15:0] SP;
 
 initial begin
   SP <= 16'd399; 
 end
 
 always @ (*) begin
  if(psh == 1'b1) begin
     SP <= SP - 1;
     data_out <= SP;
  end
  
  if(pop) begin
    data_out <= SP;
    SP <= SP + 1;  
  end
 end
 
 
endmodule
