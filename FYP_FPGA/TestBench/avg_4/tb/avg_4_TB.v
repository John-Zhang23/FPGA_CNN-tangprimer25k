`timescale 1 ns / 1 ps

module avg_4_TB ();

//************************Do Not Remove************************//
	initial begin
		$dumpfile("avg_4_tb.vcd");
		$dumpvars();
	end
//*************************************************************//


reg [15:0] a,b,c,d;
wire [15:0] avgout;

initial begin
	#0
	a = 16'h39D2;//0.728
	b = 16'h35A1;//0.352
	c = 16'hB0A3;//-0.145
	d = 16'h475E;//7.369

	#1
	a = 16'h0000;//0
	b = 16'h0000;//0
	c = 16'h0000;//0
	d = 16'h0000;//0

	#1
	a = 16'h0000;//0
	b = 16'h39D2;//0.728
	c = 16'hD0A4;//-37.13
	d = 16'h4BD6;//15.672

	#1
	$finish();
end

avg avg0
(a,b,c,d,avgout);

endmodule

