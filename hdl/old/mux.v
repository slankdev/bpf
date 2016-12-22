
module mux(
	input  [7:0][0:3] regs  ,
	input  [1:0]      select,
	output [7:0]      result
);

	function [7:0] mux4to1;
		input [7:0][0:3] r;
		input [1:0] sel;
		begin
			if      (sel == 2'd0) mux4to1 = r[0];
			else if (sel == 2'd1) mux4to1 = r[1];
			else if (sel == 2'd2) mux4to1 = r[2];
			else if (sel == 2'd3) mux4to1 = r[3];
			else mux4to1 = 7'bz;
		end
	endfunction

	assign result = mux4to1(regs, select);
endmodule
