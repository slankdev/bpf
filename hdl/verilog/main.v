

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
	end

	always #(STEP/2) begin
		$display();
		$display(" pc: %d", cpu0.pc);
		$display(" r0(%d), r1(%d), r2(%d), r3(%d)",
			cpu0.regs[0],
			cpu0.regs[1],
			cpu0.regs[2],
			cpu0.regs[3]
		);
		$display("  inst  : %x %x %x",
			cpu0.opcode, cpu0.in1_idx, cpu0.in2_idx
		);
		$display("  result: %x", cpu0.out);
	end

	reg clk;
	cpu cpu0(clk);

endmodule


