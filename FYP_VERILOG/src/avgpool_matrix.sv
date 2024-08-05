module avgpool_matrix 
#(
parameter width = 28,
parameter height = 28,
parameter depth = 6
)

(
input clk,rst,
input [15:0]in[0:depth-1][0:height-1][0:width-1],
output reg [15:0]out[0:depth-1][0:height/2-1][0:width/2-1]
);



integer cnt=0;
integer i,j,k,l;
/*
always @(posedge clk or posedge rst) begin 
if (rst == 1'b1) cnt =0;
else if(cnt < depth) cnt = cnt+1;
end

always @(*) begin 
     for (i=0; i<height; i=i+1)begin
        for (j=0;j<width; j=j+1)begin
            apsin[i][j]  = in[cnt][i][j];
        end
    end
end     

always @(*) begin 
     for (k=0; k<height/2; k=k+1)begin
        for (l=0;l<width/2; l=l+1)begin
            out[cnt][k][l] = apsout[k][l];
        end
    end
end  */

avgpool_onelayer
#(
    .width (width),
    .height (height)
)
avgone
(
    .in (in[cnt]),
    .out (out[cnt])
);

/*
always @(*) begin 
    apsin = in [cnt][0:height-1][0:width-1];
    out[cnt][0:height/2-1][0:width/2-1] = apsout[0:height/2-1][0:width/2-1];
end */

/*
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
*/

/*
genvar i;
generate 
    for (i=0; i<=depth; i = i+1) begin 
        avgpool_onelayer#(
            .width(width),
            .height(height)
           )
        agp
        (
         .in (in[i][0:height-1][0:width-1]),
         .out (out[i][0:height-1][0:width-1])
        );
    end
endgenerate
*/

endmodule