

module fetch(
	input clk,
	input rst,
	input [7:0] pc,
	output reg [15:0] instruction
);

	reg [15:0] mem [0:2047];
	initial begin
		$readmemb("program.rom", mem);
	end

	always @(posedge clk) begin
		instruction = mem[pc];
	end

	always @(posedge clk) begin
		$display("----------------------------------------------------");
		$display("FETCH  : %b", mem[pc]);
	end
endmodule
