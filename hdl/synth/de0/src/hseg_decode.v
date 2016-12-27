
module hseg_decode(
	input  [3:0] iNUM,
	input  iDOT,
	output [7:0] oHSEG
);

	function [6:0]seg_dec;
		input [3:0]num;
		case(num)
			4'h0:    seg_dec = 7'b1000000;//0
			4'h1:    seg_dec = 7'b1111001;//1
			4'h2:    seg_dec = 7'b0100100;//2
			4'h3:    seg_dec = 7'b0110000;//3
			4'h4:    seg_dec = 7'b0011001;//4
			4'h5:    seg_dec = 7'b0010010;//5
			4'h6:    seg_dec = 7'b0000010;//6
			4'h7:    seg_dec = 7'b1011000;//7
			4'h8:    seg_dec = 7'b0000000;//8
			4'h9:    seg_dec = 7'b0010000;//9
			4'ha:    seg_dec = 7'b0100000;//a
			4'hb:    seg_dec = 7'b0000011;//b
			4'hc:    seg_dec = 7'b0100111;//c
			4'hd:    seg_dec = 7'b0100001;//d
			4'he:    seg_dec = 7'b0000100;//e
			4'hf:    seg_dec = 7'b0001110;//f
		endcase
	endfunction

	assign oHSEG[6:0] = seg_dec(iNUM);
	assign oHSEG[7]   = ~iDOT;
endmodule





