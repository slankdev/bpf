
module execute(
	input clk,
	input [7:0][0:3] regs,
	input [3:0] opcode,
	input [7:0] in1_val,
	input [7:0] in2_val,
	input [1:0] dst_idx,
	output reg [7:0][0:3] nregs
);

	wire [7:0] out;
	alu alu0(in1_val, in2_val, opcode, out);

	always @(posedge clk) begin
		$display("EXECUTE: op=%-d  dst=%-d src=%-d ->  result=%-d",
			opcode, in1_val, in2_val, out
		);
	end

	wire [7:0][0:3] update_regs;
	demux demux_dst(
		regs,
		out,
		dst_idx,
		update_regs
	);
	always @(posedge clk) begin
		nregs = update_regs;
	end

endmodule
