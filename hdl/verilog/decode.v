

module decode(
	input  clk,
	input  [7:0][0:3] regs,
	input  [7:0] instruction,
	output [3:0] opcode,
	output [7:0] in1_val,
	output [7:0] in2_val,
	output [1:0] dst_idx
);

	assign opcode  = instruction[7:4];

	wire [1:0] in1_idx;
	wire [1:0] in2_idx;
	assign in1_idx = instruction[3:2];
	assign in2_idx = instruction[1:0];
	assign dst_idx = in1_idx;

	mux mux_in1(
		regs,
		in1_idx,
		in1_val
	);

	mux mux_in2(
		regs,
		in2_idx,
		in2_val
	);

	always @(posedge clk) begin
		$display("DECODE : %b %b %b   dst=%-d src=%-d",
			instruction[7:4],
			instruction[3:2],
			instruction[1:0],
			in1_val, in2_val
		);
	end

endmodule
