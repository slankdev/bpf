

module cpu(
	input iRST,
	input iCLK
);

	wire clk_IF;
	wire clk_ID;
	wire clk_AL;
	wire clk_EX;
	clk_gen CLK_GEN(
		.iCLK  (iCLK),
		.iRST  (iRST),
		.oSTEP1(clk_IF),
		.oSTEP2(clk_ID),
		.oSTEP3(clk_AL),
		.oSTEP4(clk_EX)
	);

endmodule
