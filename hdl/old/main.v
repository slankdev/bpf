

`timescale 1ns / 1ps
module main;
	parameter STEP = 100000;

	always #(STEP/2) clk = ~clk;
	initial
	begin
		#0    clk = 0;
		#STEP clk = 1;
		#(STEP * 20);
		$finish;
	end

	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(0, cpu0);
		cpu0.regs[0] = 7'd4;
		cpu0.regs[1] = 7'd2;
		cpu0.regs[2] = 7'd2;
		cpu0.regs[3] = 7'd4;
		cpu0.pc = 0;
		rst = 0;
	end

	reg clk;
	reg rst;
	cpu cpu0(clk, rst);

endmodule


