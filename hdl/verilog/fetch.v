

module fetch(
	input clk,
	input [7:0] pc,
	output reg [7:0] instruction
);

	reg [7:0] mem [0:2047];
	initial
	begin
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
