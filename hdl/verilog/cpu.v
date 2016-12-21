

module cpu(
	input clk
);
	reg [7:0][0:3] regs;
	reg  [7:0] pc;

	wire step1;
	wire step2;
	wire step3;
	wire step4;
	clk_gen clk_gen0(clk, step1, step2, step3, step4);

	wire [7:0] instruction;
	cpu_if cpu_if0(
		step1,
		pc,
		instruction
	);

	wire [7:0] in1_val;
	wire [7:0] in2_val;
	wire [1:0] dst_idx;
	wire [3:0] opcode;
	cpu_dc cpu_dc0(
		step2,
		regs,
		instruction,
		opcode,
		in1_val,
		in2_val,
		dst_idx
	);

	wire [7:0] out;
	cpu_ex cpu_ex0(
		step3,
		opcode,
		in1_val,
		in2_val,
		out
	);

	wire [7:0][3:0] nregs;
	cpu_wb cpu_wb0(
		step4,
		regs,
		dst_idx,
		out,
		nregs
	);
	always @(negedge step4) begin
		// regs = nregs;
	end

	// always @(posedge clk) begin
	// 	pc = pc + 1;
	// end

endmodule
