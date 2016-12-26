

module fetch(
	input iRST,
	input iCLK,
	input [7:0] iPC,
	output reg [15:0] oINSTRUCTION
);

	reg [15:0] mem [0:2047];
	initial begin
		$readmemb("program.rom", mem);
	end

	always @(posedge iCLK) begin
		oINSTRUCTION <= mem[iPC];
	end

	always @(negedge iCLK) begin
		$display("----------------------------------------------------");
		$display("FETCH   : PC=%-d %b", iPC, oINSTRUCTION);
	end

endmodule
