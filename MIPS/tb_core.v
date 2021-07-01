`timescale 1 ns / 10 ps
module tb_core();

reg	clk;
reg	rst_n;

core m_core(clk, rst_n);

initial begin
	rst_n = 1;
	#1 rst_n = 0;
	#1 rst_n = 1;
end

initial begin
	clk=1;
	forever #20 clk = ~clk;
end


initial
begin
//      $monitor (" %d: %b $b %b\n", $stime, ???, ???, ???);
        # 10000 $finish;
end

initial
begin
        $dumpfile ("Debug/core.vcd");
        $dumpvars;
end

endmodule 
