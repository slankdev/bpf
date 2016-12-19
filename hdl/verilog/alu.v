
module alu(
	input  [7:0] i1,
	input  [7:0] i2,
	input  [7:0] op,
	output [7:0] o
);

parameter op_add = 1;
parameter op_sub = 2;
parameter op_mul = 3;
parameter op_div = 4;
parameter op_and = 5;
parameter op_or  = 6;
parameter op_not = 7;

	function [7:0] decode;
	  input [7:0] a_i1;
	  input [7:0] a_i2;
	  input [3:0] a_ctl;
	  case (a_ctl)
	  	op_add:  decode = a_i1 + a_i2;
	  	op_sub:  decode = a_i1 - a_i2;
		op_mul:  decode = a_i1 * a_i2;
		op_div:  decode = a_i1 / a_i2;
		op_and:  decode = a_i1 & a_i2;
		op_or :  decode = a_i1 | a_i2;
		op_not:  decode = ~a_i1;
	  	default: decode = 0;
	  endcase
	endfunction

	assign o = decode(i1, i2, op);
endmodule



