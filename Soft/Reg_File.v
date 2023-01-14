`timescale 1ns / 1ps

module Reg_File(
 input    clk,
 input write_or_read,  // daca e 1 vom face write
 input [15:0] write_data,
 input reg_address,
 output [15:0] read 
);

 reg [15:0] x, y;
 
 initial begin
   x <= 16'd0;
   y <= 16'd0;
 end
 
 always @ (posedge clk ) begin
   if(write_or_read) begin //daca e 1 => LOAD
     if(reg_address) begin
       y <= write_data;
     end
     else begin
       x <= write_data;
     end      
   end
 end
 

 assign read = reg_address ? y : x;
 
endmodule
