module top_de0(
	input  [2:0] BTN,
	input  [9:0] SW,
	output [9:0] LED,
	output [7:0] HLED0,
	output [7:0] HLED1,
	output [7:0] HLED2,
	output [7:0] HLED3
);

	reg [3:0] cnt;
	always @(posedge BTN[0]) begin
		cnt = cnt + 1;
	end

	hseg_decode D(
		.iNUM(cnt),
		.iDOT(1'b1),
		.oHSEG(HLED0)
	);

	hseg_decode D1(
		.iNUM(SW[3:0]),
		.iDOT(1'b0),
		.oHSEG(HLED1)
	);

endmodule

