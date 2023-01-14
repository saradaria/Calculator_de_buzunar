library verilog;
use verilog.vl_types.all;
entity Stack_Pointer is
    port(
        pop             : in     vl_logic;
        psh             : in     vl_logic;
        data_out        : out    vl_logic_vector(15 downto 0)
    );
end Stack_Pointer;
