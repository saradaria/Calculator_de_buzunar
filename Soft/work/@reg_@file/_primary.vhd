library verilog;
use verilog.vl_types.all;
entity Reg_File is
    port(
        clk             : in     vl_logic;
        write_or_read   : in     vl_logic;
        write_data      : in     vl_logic_vector(15 downto 0);
        reg_address     : in     vl_logic;
        read            : out    vl_logic_vector(15 downto 0)
    );
end Reg_File;
