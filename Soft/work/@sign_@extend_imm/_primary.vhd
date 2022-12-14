library verilog;
use verilog.vl_types.all;
entity Sign_Extend_imm is
    port(
        imm             : in     vl_logic_vector(8 downto 0);
        imm_extend      : out    vl_logic_vector(15 downto 0)
    );
end Sign_Extend_imm;
