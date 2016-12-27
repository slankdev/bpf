

module demux(
	input  [7:0][0:3] regs  ,
	input  [7:0]      val   ,
	input  [1:0]      select,
	output [7:0][0:3] update_regs
);

	assign update_regs[0] = (select==2'd0) ? val : regs[0];
	assign update_regs[1] = (select==2'd1) ? val : regs[1];
	assign update_regs[2] = (select==2'd2) ? val : regs[2];
	assign update_regs[3] = (select==2'd3) ? val : regs[3];
endmodule
