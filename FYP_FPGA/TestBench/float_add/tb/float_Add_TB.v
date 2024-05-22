`timescale 1 ns / 1 ps

module floatAdd_TB ();

//************************Do Not Remove************************//
	initial begin
		$dumpfile("floatadd_tb.vcd");
		$dumpvars();
	end
//*************************************************************//


reg [15:0] floatA;
reg [15:0] floatB;
wire [15:0] sum;

initial begin
	#0
	floatA = 16'h39D2;//0.728
	floatB = 16'h35A1;//0.352

	#1
	floatA = 16'h35A1;//0.352
	floatB = 16'h0000;//0
	#1
	floatA = 16'h0000;//0
	floatB = 16'h39D2;//0.728
	#1
	floatA = 16'hD0A4;//-37.13
	floatB = 16'h4BD6;//15.672

	#1
	$finish();
end

floatAdd FADD
(
	.floatA(floatA),
	.floatB(floatB),
	.sum(sum)
);

endmodule

