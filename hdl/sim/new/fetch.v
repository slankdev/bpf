

module fetch(
	input iRST,
	input iCLK_IF,
	input iCLK_WB,
	input iNEXT_PC,
	output reg [15:0] oINSTRUCTION,
	output [7:0] oNEXT_PC
);

	reg [7:0] pc;
	always @(posedge iRST) begin
		pc       <= 0;
	end

	reg [15:0] mem [0:2047];
	initial begin
		$readmemb("program.rom", mem);
	end

	always @(posedge iCLK_IF) begin
		oINSTRUCTION <= mem[pc];
	end

	always @(posedge iCLK_WB) begin
		pc <= pc + 1;
	end

	assign oNEXT_PC      = pc     ;

	always @(negedge iCLK_IF) begin
		$display("----------------------------------------------------");
		$display("FETCH   : PC=%-d %b", oNEXT_PC, oINSTRUCTION);
	end

endmodule
