module avgpool_matrix 
#(
parameter width = 28,
parameter height = 28,
parameter depth = 6
)
(
input clk,rst,
input [0:16*width*height*depth-1] matrix_in,
output reg [0:width*height*depth*4-1] matrix_out
);

reg [0:16*width*height-1] apsin;
wire [0:width*height*4-1] apsout;
integer cnt;

always @(posedge clk or posedge rst) begin 
if (rst == 1'b1) cnt =0;
else if(cnt < depth) cnt = cnt+1;
end

always @(*) begin
    apsin = matrix_in[cnt*16*height*width +: 16*height*width];
    matrix_out[width*height*cnt*4 +:width*height*4] = apsout;
end

avgpool_onelayer
#(
    .width (width),
    .height (height)
)
avgone
(
.in (apsin),
.out (apsout)
);






/*
generate 
    for (i=1; i<=depth; i = i+1) begin 
        avgpool_onelayer#(
            .width(width),
            .height(height)
           )
        agp
        (
         .in (matrix_in[16*width*height*i-1 -: 16*width*height]),
         .out (matrix_out[16*width*height*i/4-1 -:16*width*height/4])
        );
    end
endgenerate
*/

endmodule