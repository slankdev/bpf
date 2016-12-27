

module decode(
	input  clk,
	input  rst,
	input  [7:0][0:3] regs,
	input  [insn_len-1:0] instruction,
	output [3:0] opcode,
	output [7:0] in1_val,
	output [7:0] in2_val,
	output [1:0] dst_idx
);

parameter insn_len = 16;
parameter op_head  = insn_len - 1;
parameter op_tail  = op_head  - 3;
parameter in1_head = op_tail  - 1;
parameter in1_tail = in1_head - 1;
parameter in2_head = in1_tail - 1;
parameter in2_tail = in2_head - 1;
parameter imd_head = in2_tail - 1;
parameter imd_tail = imd_head - 7;

parameter op_mov_imm = 4'd8;

	wire [7:0] imm_val;
	assign opcode  = instruction[op_head:op_tail];

	wire [1:0] in1_idx;
	wire [1:0] in2_idx;
	assign in1_idx = instruction[in1_head:in1_tail];
	assign in2_idx = instruction[in2_head:in2_tail];
	assign dst_idx = in1_idx;
	assign imm_val = instruction[imd_head:imd_tail];

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
	// if (instruction[op_head:op_tail] == op_mov_imm)
	// begin
    //
	// end


	always @(posedge clk) begin
		$display("DECODE : %b %b %b %b  dst=%-d src=%-d",
			instruction[op_head:op_tail],
			instruction[in1_head:in1_tail],
			instruction[in2_head:in2_tail],
			instruction[imd_head:imd_tail],
			in1_val, in2_val
		);
	end

endmodule
