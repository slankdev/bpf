

module cpu_wb(
	input  clk,
	input  [7:0][0:3] regs,
	input  [1:0] dst_idx,
	input  [7:0] dst_val,
	output reg [7:0][0:3] nregs
);

	wire [7:0][0:3] update_regs;
	demux demux_dst(
		regs,
		dst_val,
		dst_idx,
		update_regs
	);

	always @(posedge clk) begin
		nregs = update_regs;
	end

	always @(posedge clk) begin
		$display("WRIBACK: %4d %4d %4d %4d -> %4d %4d %4d %4d",
			regs[0],
			regs[1],
			regs[2],
			regs[3],
			nregs[0],
			nregs[1],
			nregs[2],
			nregs[3]
		);
	end

endmodule
