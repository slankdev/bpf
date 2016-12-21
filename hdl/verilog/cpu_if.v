

module cpu_if(
	input clk,
	input [7:0] pc,
	output [7:0] instruction
);
	wire [7:0] instruction;
	rom rom0(clk, pc, instruction);

	always @(posedge clk) begin
		$display("FETCH  : %4x", instruction);
	end
endmodule
