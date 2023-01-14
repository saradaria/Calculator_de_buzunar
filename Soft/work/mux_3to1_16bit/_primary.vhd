library verilog;
use verilog.vl_types.all;
entity mux_3to1_16bit is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        c               : in     vl_logic_vector(15 downto 0);
        d               : in     vl_logic_vector(15 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end mux_3to1_16bit;
