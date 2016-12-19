

module cpu(
	input clk
);
	reg [7:0][0:3] regs;

	reg  [7:0] pc;
	wire [15:0] instruction;
	rom rom0(clk, pc, instruction);

	wire [7:0] opcode;
	wire [3:0] in1_idx;
	wire [3:0] in2_idx;
	assign opcode  = instruction[15:8];
	assign in1_idx = instruction[7:4];
	assign in2_idx = instruction[3:0];

	wire [7:0] in1_val;
	wire [7:0] in2_val;

	mux mux_in1(
		clk,
		regs,
		in1_idx,
		in1_val
	);

	mux mux_in2(
		clk,
		regs,
		in2_idx,
		in2_val
	);

	wire [7:0] out;
	alu alu0(in1_val, in2_val, opcode, out);

	always @(posedge clk) begin
		pc = pc + 1;
	end


endmodule
