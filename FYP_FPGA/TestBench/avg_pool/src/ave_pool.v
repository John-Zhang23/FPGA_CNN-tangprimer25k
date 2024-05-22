module avg_pool
(
input [15:0] in [27:0] [27:0],
output [15:0] out [13:0] [13:0]
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

