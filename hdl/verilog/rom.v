

module rom(
	input clk,
	input [7:0] address,
	output reg [7:0] data
);


	reg [7:0] mem [0:2047];

	reg [7:0] i;
	initial
	begin
		$readmemh("test.rom", mem);
		// for (i=0; i<10; i=i+1)
		// 	$display("%x: %x",i, mem[i]);
	end

	always @(posedge clk) begin
		data = mem[address];
	end

endmodule
