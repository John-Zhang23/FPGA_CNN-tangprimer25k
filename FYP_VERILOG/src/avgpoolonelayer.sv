module avgpool_onelayer
#(
parameter width = 28,
parameter height = 28
)
(
input [15:0]in[0:height-1][0:width-1],
output [15:0]out[0:height/2-1][0:width/2-1]
);
genvar i,j;
generate 
    for (i=0; i<height; i = i+2) begin 
        for (j=0; j<width; j = j+2) begin 
            avg ag(
                    .a (in[i][j]),
                    .b (in[i][j+1]),
                    .c (in[i+1][j]),
                    .d (in[i+1][j+1]),
                    .avgout (out[i/2][j/2])
                   );
        end
    end 
endgenerate
endmodule

