`timescale 1 ns / 1 ps

module avg_pool_TB ();

//************************Do Not Remove************************//
	initial begin
		$dumpfile("avg_pool_TB.vcd");
		$dumpvars();
	end
//*************************************************************//


reg [15:0] a[27:0][27:0];
wire [15:0] avgout [14:0] [14:0];

initial begin
	#0
		[15:0]a[27:0][27:0] = 16h2548;
	#1
	$finish();
end

avg_pool ap0
(a,avgout );

endmodule

