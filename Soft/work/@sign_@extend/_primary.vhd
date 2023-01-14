library verilog;
use verilog.vl_types.all;
entity Sign_Extend is
    port(
        imm             : in     vl_logic_vector(9 downto 0);
        imm_extend      : out    vl_logic_vector(15 downto 0)
    );
end Sign_Extend;
