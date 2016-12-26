

`timescale 1ns / 1ps
module main;
	parameter STEP = 100000;
	parameter LOOP = 6;

	always #(STEP/2) clk = ~clk;
	initial
	begin
		#0    clk = 0;
		#STEP clk = 1;
		#(STEP * (5*LOOP + 1));
		$finish;
	end

	initial rst = 1;
	always #(STEP)
	begin
		rst = 0;
	end

	always #(STEP/2)
	begin
		// $display("clk=%b, rst=%b", clk, rst);
		// $display("clk=%b, rst=%b, if=%b, id=%b, al=%b, ex=%b",
		// 	CPU.iCLK,
		// 	CPU.iRST,
		// 	CPU.clk_IF,
		// 	CPU.clk_ID,
		// 	CPU.clk_AL,
		// 	CPU.clk_EX
		// );
	end

	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(0, main);
	end

	reg clk;
	reg rst;

	cpu CPU(
		.iRST(rst),
		.iCLK(clk)
	);

endmodule


