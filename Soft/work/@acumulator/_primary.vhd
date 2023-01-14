library verilog;
use verilog.vl_types.all;
entity Acumulator is
    port(
        alu_out         : in     vl_logic_vector(15 downto 0);
        ACC_out         : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end Acumulator;
