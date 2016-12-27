

module clk_gen(
	input clk,
	input rst,
	output reg step1,
	output reg step2,
	output reg step3,
	output reg step4
);

	always @(rst) begin
		cnt = 0;
		step1 = 0;
		step2 = 0;
		step3 = 0;
		step4 = 0;
	end

	reg [1:0] cnt;
	always @(posedge clk) begin
		if (cnt == 2'd0)
		begin
			step1 = 1'b1;
			step2 = 1'b0;
			step3 = 1'b0;
			step4 = 1'b0;
		end
		else if (cnt == 2'd1)
		begin
			step1 = 1'b0;
			step2 = 1'b1;
			step3 = 1'b0;
			step4 = 1'b0;
		end
		else if (cnt == 2'd2)
		begin
			step1 = 1'b0;
			step2 = 1'b0;
			step3 = 1'b1;
			step4 = 1'b0;
		end
		else if (cnt == 2'd3)
		begin
			step1 = 1'b0;
			step2 = 1'b0;
			step3 = 1'b0;
			step4 = 1'b1;
		end

		cnt = cnt+1;
	end

endmodule
