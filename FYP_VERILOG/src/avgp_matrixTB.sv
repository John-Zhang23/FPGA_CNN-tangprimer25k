`timescale 1 ns / 100 ps

module avg_pool_TB ();

reg clk,rst;
reg [15:0] inAvg[2:0][3:0][3:0];
wire [15:0] outAvg[2:0][1:0][1:0];

localparam PERIOD = 200;

integer i;

always
	#(PERIOD/2) clk = ~clk;
	
initial begin
    #0
    clk = 1'b0;
	  rst = 0;
    inAvg = 768'h3C00_4000_4200_4400_4500_4600_4700_4800_4880_4900_4980_4A00_4A80_4B00_4B80_4C00_3C00_4000_4200_4400_4500_4600_4700_4800_4880_4900_4980_4A00_4A80_4B00_4B80_4C00_3C00_4000_4200_4400_4500_4600_4700_4800_4880_4900_4980_4A00_4A80_4B00_4B80_4C00;
    #(4*PERIOD)
	  rst = 0;
    #(10)
    $finish();
end


avgpool_matrix 
  #(
  .depth(3),
  .height(4),
  .width(4)
  )avgmtx
  (
    .clk(clk),
    .rst(rst),
    .matrix_in(inAvg),
    .matrix_out(outAvg)
  );
endmodule
