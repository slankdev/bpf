

`include "core.h"

module execute(
	input  iRST,
	input  iCLK,

	input  [3:0] iEXE_CMD,
	input  [7:0] iSOURCE0,
	input  [7:0] iSOURCE1,
	output [7:0] oRESULT
);

	reg [7:0] result;
	always @(posedge iRST) begin
		result <= 0;
	end

	wire [7:0] alu_result;
	execute_alu EX_ALU(
		.iOPCODE (iEXE_CMD),
		.iSOURCE0(iSOURCE0),
		.iSOURCE1(iSOURCE1),
		.oRESULT (alu_result)
	);

	always @(posedge iCLK) begin
		result = alu_result;
	end

	assign oRESULT = result;

	always @(negedge iCLK) begin
		$display("EXECUTE : op=%b src0=%-d src1=%-d res=%-d",
			iEXE_CMD,
			iSOURCE0,
			iSOURCE1,
			oRESULT
		);
	end
endmodule
