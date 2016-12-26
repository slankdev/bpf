

module decode(
	input  iRST,
	input  iCLK,
	input  [15:0] iINSTRUCTION,
	output [3:0] oEXE_OP,
	output [1:0] oIN1_IDX,
	output [1:0] oIN2_IDX,
	output [7:0] oIMM_VAL,
	output [1:0] oDST_IDX,
	output oSRC2_IS_REG_OR_IMM
);

	wire [3:0] dc_exe_op;
	wire [1:0] dc_in1_idx;
	wire [1:0] dc_in2_idx;
	wire [7:0] dc_imm_val;
	wire [1:0] dc_dst_idx;
	wire dc_src2_is_reg_or_imm;
	decode_function DECODE_FUNCTION(
		.iINSTRUCTION(iINSTRUCTION),
		.oDECODE_EXE_OPCODE        (dc_exe_op            ),
		.oDECODE_IN1_IDX           (dc_in1_idx           ),
		.oDECODE_IN2_IDX           (dc_in2_idx           ),
		.oDECODE_IMM_VAL           (dc_imm_val           ),
		.oDECODE_DEST_IDX          (dc_dst_idx           ),
		.oDECODE_SRC1_IS_REG_OR_IMM(dc_src2_is_reg_or_imm)
	);

	reg [3:0] exe_op ;
	reg [1:0] in1_idx;
	reg [1:0] in2_idx;
	reg [7:0] imm_val;
	reg [1:0] dst_idx;
	reg src2_is_reg_or_imm;
	always @(posedge iCLK) begin
		exe_op   =  dc_exe_op ;
		in1_idx  =  dc_in1_idx;
		in2_idx  =  dc_in2_idx;
		imm_val  =  dc_imm_val;
		dst_idx  =  dc_dst_idx;
		src2_is_reg_or_imm = dc_src2_is_reg_or_imm;
	end

	assign oEXE_OP  = exe_op ;
	assign oIN1_IDX = in1_idx;
	assign oIN2_IDX = in2_idx;
	assign oIMM_VAL = imm_val;
	assign oDST_IDX = dst_idx;
	assign oSRC2_IS_REG_OR_IMM = src2_is_reg_or_imm;

	always @(negedge iCLK) begin
		$display("DECODE  : %b %b %b %b dst_idx=%d",
			oEXE_OP ,
			oIN1_IDX,
			oIN2_IDX,
			oIMM_VAL,
			oDST_IDX
		);
	end
endmodule



