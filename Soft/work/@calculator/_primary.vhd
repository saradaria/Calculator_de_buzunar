library verilog;
use verilog.vl_types.all;
entity Calculator is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        pc              : out    vl_logic_vector(15 downto 0);
        inst            : out    vl_logic_vector(15 downto 0);
        al              : out    vl_logic_vector(15 downto 0);
        rr              : out    vl_logic_vector(15 downto 0)
    );
end Calculator;
