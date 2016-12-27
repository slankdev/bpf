
module mux(
	input  [7:0] iREGS [0:3] ,
	input  [1:0]      iSELECT,
	output [7:0]      oRESULT
);

	function [7:0] mux4to1;
		input [7:0] r0;
		input [7:0] r1;
		input [7:0] r2;
		input [7:0] r3;
		input [1:0] sel;
		begin
			if      (sel == 2'd0) mux4to1 = r0;
			else if (sel == 2'd1) mux4to1 = r1;
			else if (sel == 2'd2) mux4to1 = r2;
			else if (sel == 2'd3) mux4to1 = r3;
			else mux4to1 = 7'bz;
		end
	endfunction

	assign oRESULT = mux4to1(
		iREGS[0],
		iREGS[1],
		iREGS[2],
		iREGS[3],
		iSELECT
	);
endmodule
