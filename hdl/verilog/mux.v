
module mux(
	input             clk   ,
	input  [7:0][0:3] regs  ,
	input  [3:0]      select,
	output reg [7:0]  result
);

	always @(posedge clk) begin
		case (select)
			3'd0: result <= regs[0];
			3'd1: result <= regs[1];
			3'd2: result <= regs[2];
			3'd3: result <= regs[3];
		endcase
	end

endmodule
