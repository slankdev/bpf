

`include "core.h"

module execute_alu(
	input  [3:0] iOPCODE ,
	input  [7:0] iSOURCE0,
	input  [7:0] iSOURCE1,
	output [7:0] oRESULT
);

	function [7:0] f_alu;
	  input [3:0] a_ctl;
	  input [7:0] a_i1;
	  input [7:0] a_i2;
	  case (a_ctl)
		`EX_OC_MOV:  f_alu = a_i2;
	  	`EX_OC_ADD:  f_alu = a_i1 + a_i2;
	  	default: f_alu = 8'bz;
	  endcase
	endfunction

	assign oRESULT = f_alu(iOPCODE, iSOURCE0, iSOURCE1);
endmodule
