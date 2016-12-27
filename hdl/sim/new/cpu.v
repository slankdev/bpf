

module cpu(
	input iRST,
	input iCLK
);

	wire clk_IF;
	wire clk_ID;
	wire clk_AL;
	wire clk_EX;
	wire clk_WB;
	clk_gen CLK_GEN(
		.iCLK  (iCLK),
		.iRST  (iRST),
		.oSTEP1(clk_IF),
		.oSTEP2(clk_ID),
		.oSTEP3(clk_AL),
		.oSTEP4(clk_EX),
		.oSTEP5(clk_WB)
	);

	wire [7:0] fetch_pc;
	wire [15:0] instruction;
	fetch FETCH(
		.iRST(iRST),
		.iCLK_IF(clk_IF),
		.iCLK_WB(clk_WB),
		.oINSTRUCTION(instruction)
	);

	wire [3:0] exe_op ;
	wire [1:0] in1_idx;
	wire [1:0] in2_idx;
	wire [7:0] imm_val;
	wire [1:0] dst_idx;
	wire src2_is_reg_or_imm;
	decode DECODE(
		.iCLK(clk_ID),
		.iRST(iRST),
		.iINSTRUCTION(instruction),
		.oEXE_OP (exe_op ),
		.oIN1_IDX(in1_idx),
		.oIN2_IDX(in2_idx),
		.oIMM_VAL(imm_val),
		.oDST_IDX(dst_idx),
		.oSRC2_IS_REG_OR_IMM(src2_is_reg_or_imm)
	);

	wire [7:0] ex_result;
	wire [7:0] source1_val;
	wire [7:0] source2_val;
	allocate ALLOCATE(
		.iRST(iRST),
		.iCLK_AL(clk_AL),
		.iCLK_WB(clk_WB),

		// for writeback
		.iNEXT_REG_IDX(dst_idx),
		.iNEXT_REG_VAL(ex_result),

		// for execution
		.iSOURCE1_IDX(in1_idx),
		.iSOURCE2_IDX(in2_idx),
		.iIMM_VAL    (imm_val),
		.iSRC2_IS_REG_OR_IMM(src2_is_reg_or_imm),
		.oSOURCE1_VAL(source1_val),
		.oSOURCE2_VAL(source2_val)
	);

	execute EXECUTE(
		.iCLK(clk_EX),
		.iRST(iRST),

		.iEXE_CMD(exe_op),
		.iSOURCE0(source1_val),
		.iSOURCE1(source2_val),
		.oRESULT(ex_result)
	);

endmodule
