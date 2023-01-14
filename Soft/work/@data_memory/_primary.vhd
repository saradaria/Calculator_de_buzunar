library verilog;
use verilog.vl_types.all;
entity Data_memory is
    port(
        clk             : in     vl_logic;
        Din             : in     vl_logic_vector(15 downto 0);
        write_addr      : in     vl_logic_vector(15 downto 0);
        DW_or_DR        : in     vl_logic;
        Dout            : out    vl_logic_vector(15 downto 0)
    );
end Data_memory;
