
module mux2(
	input  [7:0] iSOURCE0,
	input  [7:0] iSOURCE1,
	input        iSELECT ,
	output [7:0] oRESULT
);

	function [7:0] mux2to1;
		input [7:0] source0;
		input [7:0] source1;
		input  sel;
		begin
			if      (sel == 2'b0) mux2to1 = source0;
			else if (sel == 2'b1) mux2to1 = source1;
			else mux2to1 = 7'bz;
		end
	endfunction

	assign oRESULT = mux2to1(iSOURCE0, iSOURCE1, iSELECT);
endmodule
