

module cpu(
	input clk
);
	reg [7:0][0:3] regs;
	reg [7:0] pc;

	wire step1_clk;
	wire step2_clk;
	wire step3_clk;
	wire step4_clk;
	clk_gen clk_gen0(
		clk,
		step1_clk,
		step2_clk,
		step3_clk,
		step4_clk
	);

	wire [7:0] instruction;
	fetch fetch0(
		step1_clk,
		pc,
		instruction
	);

	wire [7:0] in1_val;
	wire [7:0] in2_val;
	wire [1:0] dst_idx;
	wire [3:0] opcode;
	decode decode0(
		step2_clk,
		regs,
		instruction,
		opcode,
		in1_val,
		in2_val,
		dst_idx
	);

	wire [7:0][0:3] nregs;
	execute execute0(
		step3_clk,
		regs,
		opcode,
		in1_val,
		in2_val,
		dst_idx,
		nregs
	);

	always @(posedge step4_clk) begin
		$display("WRIBACK: %-d %-d %-d %-d ->  %-d %-d %-d %-d",
			regs[0],
			regs[1],
			regs[2],
			regs[3],
			nregs[0],
			nregs[1],
			nregs[2],
			nregs[3],
		);
		regs = nregs;
	end

	always @(posedge step4_clk) begin
		pc <= pc + 1;
	end

endmodule
