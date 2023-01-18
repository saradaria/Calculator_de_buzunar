module Calculator(
  input clk, rst
);

wire   Z, N, C, O;
wire [15:0] instr;
wire [5:0] opcode;
wire [8:0] immediate;
wire reg_addr, write_or_read, DW_or_DR, ACC_out;
wire psh, pop, jmp, bra;
wire [9:0] jmp_addr;
wire [1:0] W_R_C;

Control_Unit CU (.Z(Z), .N(N), .C(C), .O(O), .reset(rst), .clk(clk), .instr(instr), .opcode(opcode),
                 .immediate(immediate), .reg_addr(reg_addr), .write_or_read(write_or_read), .DW_or_DR(DW_or_DR),
                 .ACC_out(ACC_out), .psh(psh), .pop(pop), .jmp(jmp), .bra(bra), .jmp_addr(jmp_addr), .W_R_C(W_R_C));
                 
wire [15:0] imm_extend;
Sign_Extend S_CU (.imm(jmp_addr), .imm_extend(imm_extend));

wire [15:0] PC_out, out;
Adder adder_CU (.a(16'd1), .b(PC_out), .out(out));

wire [15:0] PC_in;                   
mux_2to1_16bit MUX_CU (.a(imm_extend), .b(out),.sel(bra),.out(PC_in));

PC PC_CU (.clk(clk), .reset(rst),.PC_in(PC_in),.PC_out(PC_out));

Instruction_Memory IM (.pc(PC_out), .instruction(instr));

wire [15:0] imm_extend_reg;
Sign_Extend_imm S_REG (.imm(immediate), .imm_extend(imm_extend_reg));

wire [15:0] acc, d_out, write_data;
mux_3to1_16bit MUX_REG (.a(imm_extend_reg), .b(acc), .c(d_out), .sel(W_R_C), .out(write_data));

wire [15:0] read_reg;
Reg_File REG_FILE (.clk(clk), .write_or_read(write_or_read), .write_data(write_data), .reg_address(reg_addr), .read(read_reg));

wire [15:0] imm_extend_alu;
Sign_Extend_imm S_ALU (.imm(immediate), .imm_extend(imm_extend_alu));

wire [15:0] data_out_sp; 
Stack_Pointer SP (.pop(pop), .push(psh), .data_out(data_out_sp));

wire [15:0] imm_extend_sp;
Sign_Extend_imm S_SP (.imm(immediate), .imm_extend(imm_extend_sp));

wire [15:0] write_addr;                   
mux_2to1_16bit MUX_SP (.a(imm_extend_sp), .b(data_out_sp),.sel(jmp),.out(write_addr));

wire [15:0] Din;                   
mux_2to1_16bit MUX_DM (.a(read_reg), .b(PC_out),.sel(psh),.out(Din));

wire [15:0] Dout;
Data_memory DM(.clk(clk), .Din(Din), .write_addr(write_addr), .DW_or_DR(DW_or_DR), .Dout(Dout));

wire Z_alu, N_alu, C_alu ,O_alu;
Flags F (.Z(Z_alu), .N(N_alu), .C(C_alu), .O(O_alu), .Z_out(Z), .N_out(N), .C_out(C), .O_out(O));

wire [15:0] alu_out, alu_acc;
Accumulator ACC (.alu_out(alu_out), .ACC_out(ACC_out), .out(alu_acc));

ALU ALU_INST (.a(read_reg), .b(imm_extend_alu), .c(alu_acc), .opcode(opcode), .result(alu_out), .Z_out(Z_alu), .N_out(N_alu), .C_out(C_alu), .O_out(O_alu));


endmodule


