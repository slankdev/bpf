

module clk_gen(
	input iCLK,
	input iRST,
	output reg oSTEP1,
	output reg oSTEP2,
	output reg oSTEP3,
	output reg oSTEP4,
	output reg oSTEP5
);

	always @(iRST) begin
		cnt = 0;
		oSTEP1 = 0;
		oSTEP2 = 0;
		oSTEP3 = 0;
		oSTEP4 = 0;
		oSTEP5 = 0;
	end

	reg [2:0] cnt;
	always @(posedge iCLK) begin

		if (cnt == 3'd5) cnt = 0;

		if (cnt == 3'd0)
		begin
			oSTEP1 = 1'b1;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b0;
			oSTEP5 = 1'b0;
		end
		else if (cnt == 3'd1)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b1;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b0;
			oSTEP5 = 1'b0;
		end
		else if (cnt == 3'd2)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b1;
			oSTEP4 = 1'b0;
			oSTEP5 = 1'b0;
		end
		else if (cnt == 3'd3)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b1;
			oSTEP5 = 1'b0;
		end
		else if (cnt == 3'd4)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b0;
			oSTEP5 = 1'b1;
		end

		cnt = cnt+1;
	end

	// always @(negedge iCLK) begin
	// 	$display("%-b %-b %-b %-b %-b",
	// 		oSTEP1,
	// 		oSTEP2,
	// 		oSTEP3,
	// 		oSTEP4,
	// 		oSTEP5
	// 	);
	// end


endmodule
