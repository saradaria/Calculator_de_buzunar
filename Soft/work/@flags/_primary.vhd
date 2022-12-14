library verilog;
use verilog.vl_types.all;
entity Flags is
    port(
        Z               : in     vl_logic;
        N               : in     vl_logic;
        C               : in     vl_logic;
        O               : in     vl_logic;
        Z_out           : out    vl_logic;
        N_out           : out    vl_logic;
        C_out           : out    vl_logic;
        O_out           : out    vl_logic
    );
end Flags;
