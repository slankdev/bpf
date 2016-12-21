
module alu(
	input  [7:0] i1,
	input  [7:0] i2,
	input  [3:0] op,
	output [7:0] o
);

parameter op_mov = 4'd0;
parameter op_add = 4'd1;
parameter op_sub = 4'd2;
parameter op_mul = 4'd3;
parameter op_div = 4'd4;
parameter op_and = 4'd5;
parameter op_or  = 4'd6;
parameter op_not = 4'd7;

	function [7:0] decode;
	  input [7:0] a_i1;
	  input [7:0] a_i2;
	  input [3:0] a_ctl;
	  case (a_ctl)
		op_mov:  decode = a_i2;
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



