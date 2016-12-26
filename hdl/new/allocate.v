

module allocate(
	input iRST,
	input iCLK_AL,
	input iCLK_WB,

	// for writeback
	input  [1:0] iNEXT_REG_IDX,
	input  [7:0] iNEXT_REG_VAL,

	// for execution
	input  [1:0] iSOURCE1_IDX,
	input  [1:0] iSOURCE2_IDX,
	input  [7:0] iIMM_VAL    ,
	input  iSRC2_IS_REG_OR_IMM,
	output [7:0] oSOURCE1_VAL,
	output [7:0] oSOURCE2_VAL
);

	reg [7:0] regs [0:3];
	reg [7:0] source1_val;
	reg [7:0] source2_val;
	always @(posedge iRST) begin
		regs[0]  <= 0;
		regs[1]  <= 0;
		regs[2]  <= 0;
		regs[3]  <= 0;

		source1_val <= 0;
		source2_val <= 0;
	end


	always @(posedge iCLK_WB) begin
		regs[0] = (iNEXT_REG_IDX==2'd0) ? iNEXT_REG_VAL : regs[0];
		regs[1] = (iNEXT_REG_IDX==2'd1) ? iNEXT_REG_VAL : regs[1];
		regs[2] = (iNEXT_REG_IDX==2'd2) ? iNEXT_REG_VAL : regs[2];
		regs[3] = (iNEXT_REG_IDX==2'd3) ? iNEXT_REG_VAL : regs[3];
	end


	// for execution
	wire [7:0] mux_source1;
	mux MUX_SOURCE1(
		.iREGS  (regs),
		.iSELECT(iSOURCE1_IDX),
		.oRESULT(mux_source1)
	);
	wire [7:0] mux_source2_from_reg;
	mux MUX_SOURCE2_FROM_REG(
		.iREGS  (regs),
		.iSELECT(iSOURCE2_IDX),
		.oRESULT(mux_source2_from_reg)
	);
	wire [7:0] mux_source2;
	mux2 MUX_SOURCE2(
		.iSOURCE0(mux_source2_from_reg),
		.iSOURCE1(iIMM_VAL),
		.iSELECT(iSRC2_IS_REG_OR_IMM),
		.oRESULT(mux_source2)
	);

	always @(posedge iCLK_AL) begin
		source1_val <= mux_source1;
		source2_val <= mux_source2;
	end

	assign oSOURCE1_VAL  = source1_val;
	assign oSOURCE2_VAL  = source2_val;

	always @(negedge iCLK_AL) begin
		$display("ALLOCATE: %-d %-d %-d %-d src1=%-d src2=%-d",
			regs[0],
			regs[1],
			regs[2],
			regs[3],
			oSOURCE1_VAL,
			oSOURCE2_VAL
		);
	end
	always @(negedge iCLK_WB) begin
		$display("WRIBACK : %-d %-d %-d %-d",
			regs[0],
			regs[1],
			regs[2],
			regs[3],
		);
	end
endmodule
