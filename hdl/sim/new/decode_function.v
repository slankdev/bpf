


`include "core.h"

module decode_function(
	input  [15:0] iINSTRUCTION,
	output [3:0] oDECODE_EXE_OPCODE,
	output [1:0] oDECODE_IN1_IDX,
	output [1:0] oDECODE_IN2_IDX,
	output [7:0] oDECODE_IMM_VAL,
	output [1:0] oDECODE_DEST_IDX,
	output oDECODE_SRC1_IS_REG_OR_IMM
);

	function [18:0] f_decode;
		input [15:0] f_decode_inst;
		begin
			case (f_decode_inst[15:12])
				`OC_MOV :
					begin
						f_decode = {
						/* exe op       */ `EX_OC_MOV,
						/* in1 idx      */ f_decode_inst[11:10],
						/* in2 idx      */ f_decode_inst[9:8],
						/* imm_val      */ f_decode_inst[7:0],
						/* dst idx      */ f_decode_inst[11:10],
						/* src1 reg/imm */ 1'b0
						};
					end
				`OC_MOVI :
					begin
						f_decode = {
						/* exe op       */ `EX_OC_MOV,
						/* in1 idx      */ f_decode_inst[11:10],
						/* in2 idx      */ f_decode_inst[9:8],
						/* imm_val      */ f_decode_inst[7:0],
						/* dst idx      */ f_decode_inst[11:10],
						/* src1 reg/imm */ 1'b1
						};
					end
				`OC_ADD :
					begin
						f_decode = {
						/* exe op       */ `EX_OC_ADD,
						/* in1 idx      */ f_decode_inst[11:10],
						/* in2 idx      */ f_decode_inst[9:8],
						/* imm_val      */ f_decode_inst[7:0],
						/* dst idx      */ f_decode_inst[11:10],
						/* src1 reg/imm */ 1'b0
						};
					end
				`OC_ADDI :
					begin
						f_decode = {
						/* exe op       */ `EX_OC_ADD,
						/* in1 idx      */ f_decode_inst[11:10],
						/* in2 idx      */ f_decode_inst[9:8],
						/* imm_val      */ f_decode_inst[7:0],
						/* dst idx      */ f_decode_inst[11:10],
						/* src1 reg/imm */ 1'b1
						};
					end
			endcase
		end
	endfunction

	assign {
		oDECODE_EXE_OPCODE,
		oDECODE_IN1_IDX,
		oDECODE_IN2_IDX,
		oDECODE_IMM_VAL,
		oDECODE_DEST_IDX,
		oDECODE_SRC1_IS_REG_OR_IMM
	} = f_decode(iINSTRUCTION);

endmodule


