library verilog;
use verilog.vl_types.all;
entity Control_Unit is
    port(
        Z               : in     vl_logic;
        N               : in     vl_logic;
        C               : in     vl_logic;
        O               : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        instr           : in     vl_logic_vector(15 downto 0);
        opcode          : out    vl_logic_vector(5 downto 0);
        immediate       : out    vl_logic_vector(8 downto 0);
        reg_addr        : out    vl_logic;
        write_or_read   : out    vl_logic;
        DW_or_DR        : out    vl_logic;
        ACC_out         : out    vl_logic;
        psh             : out    vl_logic;
        pop             : out    vl_logic;
        jmp             : out    vl_logic;
        bra             : out    vl_logic;
        jmp_addr        : out    vl_logic_vector(9 downto 0);
        W_R_C           : out    vl_logic_vector(1 downto 0)
    );
end Control_Unit;
