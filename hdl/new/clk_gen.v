

module clk_gen(
	input iCLK,
	input iRST,
	output reg oSTEP1,
	output reg oSTEP2,
	output reg oSTEP3,
	output reg oSTEP4
);

	always @(iRST) begin
		cnt = 0;
		oSTEP1 = 0;
		oSTEP2 = 0;
		oSTEP3 = 0;
		oSTEP4 = 0;
	end

	reg [1:0] cnt;
	always @(posedge iCLK) begin

		if (cnt == 2'd0)
		begin
			oSTEP1 = 1'b1;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b0;
		end
		else if (cnt == 2'd1)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b1;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b0;
		end
		else if (cnt == 2'd2)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b1;
			oSTEP4 = 1'b0;
		end
		else if (cnt == 2'd3)
		begin
			oSTEP1 = 1'b0;
			oSTEP2 = 1'b0;
			oSTEP3 = 1'b0;
			oSTEP4 = 1'b1;
		end

		cnt = cnt+1;
	end

endmodule
