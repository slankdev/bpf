
`timescale 1ns / 1ps
module main;
	reg clk;
	reg [7:0] a;
	reg [7:0] b;
	reg [3:0] ctl;
	wire [7:0] out;


	parameter STEP = 10;
	always #(STEP/2) clk = ~clk;
	initial
	begin
		a   = 20;
		b   = 4;
		ctl = 4;
		#0    clk = 0;
		#STEP clk = 1;
		#(STEP * 20)
		$finish;
	end

	alu alu0(a, b, ctl, out);

	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(0, main);
	end
	initial $monitor ($stime, ":     a=%-d  b=%-d  ctl=%-d  out=%-d", a,b,ctl,out);

endmodule
