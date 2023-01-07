library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        c               : in     vl_logic_vector(7 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0);
        result          : out    vl_logic_vector(15 downto 0);
        Z_out           : out    vl_logic;
        N_out           : out    vl_logic;
        C_out           : out    vl_logic;
        O_out           : out    vl_logic
    );
end ALU;
