

`timescale 1ns / 1ps
module main;
	parameter STEP = 100;
	always #(STEP/2) clk = ~clk;
	initial
	begin
		#0    clk = 0;
		#STEP clk = 1;
		#(STEP * 10)
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
		cpu0.clk_gen0.cnt = 0;
		cpu0.cpu_wb0.nregs = 0;
	end

	always #(STEP) begin
		// $display(" clks: %b [%b %b %b %b]", clk,
		// 	cpu0.step1, cpu0.step2,
		// 	cpu0.step3, cpu0.step4
		// );
		// $display(" pc: %d", cpu0.pc);
		// $display(" registers: %4d %4d %4d %4d",
		// 	cpu0.regs[0],
		// 	cpu0.regs[1],
		// 	cpu0.regs[2],
		// 	cpu0.regs[3]
		// );
		// $display("  inst  : %x %x %x",
		// 	cpu0.opcode, cpu0.in1_idx, cpu0.in2_idx);
		// $display("  result: %x", cpu0.out);
	end

	reg clk;
	cpu cpu0(clk);

endmodule


