
module cpu_ex(
	input clk,
	input [3:0] opcode,
	input [7:0] in1   ,
	input [7:0] in2   ,
	output reg [7:0] result
);

	wire [7:0] out;
	alu alu0(in1, in2, opcode, out);

	always @(posedge clk) begin
		result = out;
	end

	always @(posedge clk) begin
		$display("EXECUTE: %4d(%4d, %4d) -> %4d", opcode, in1, in2, out);
	end

endmodule
