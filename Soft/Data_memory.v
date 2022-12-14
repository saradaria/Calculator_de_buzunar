`include "Parameter.v"

module Data_memory(
 input clk,
 input  [15:0] Din, write_addr, 
 input  DW_or_DR, // daca e 1 - DW 0- DR
 output reg [15:0] Dout
 );
 
 
reg [`col - 1:0] memory [`row_d - 1:0];
integer f;
//wire [2:0] ram_addr = mem_access_addr[2:0];

initial begin
  $readmemb("./test/test.data", memory);
end
 
 always @(posedge clk) begin
  if (DW_or_DR) begin
    memory[write_addr] <= Din;
  end
  else begin
    Dout <= memory[write_addr];
  end

 end
 
endmodule
