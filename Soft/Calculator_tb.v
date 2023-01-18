`timescale 1ns / 1ps

module Calculator_tb;

reg clk, rst;

wire [15:0] pc;
wire [15:0] inst;
wire [15:0] al;
wire [15:0] rr;


Calculator calc (clk, rst, pc, inst, al, rr);


initial
    begin
        rst <= 1; # 22; rst <= 0;
    end
    

always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end


always begin
    if(inst == 16'b0) begin
        #10;
        $stop;
    end else begin
        #10;
    end
end

endmodule
