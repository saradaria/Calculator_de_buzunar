`include "Parameter.v"

module Instruction_Memory(
 input[15:0] pc,     //adresa unde e instr
 output[15:0] instruction
);

 reg [15 : 0] memory [`row_i - 1:0]; //vector cu x elem de 16 biti
 wire [3 : 0] rom_addr = pc[4 : 1];  //pc returneaza adresa instr ce trb facuta
 initial
 begin
  $readmemb("../rom.txt", memory,0, `row_i - 1);// data file name, memory name, start/end address
 end
 assign instruction =  memory[rom_addr]; 

endmodule
