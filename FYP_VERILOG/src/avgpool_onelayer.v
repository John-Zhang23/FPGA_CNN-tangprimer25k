module avgpool_onelayer
#(
parameter width = 28,
parameter height = 28
)
(
input [0:16*height*width-1]in,
output [0:height*width*4-1]out
);
genvar i,j;
generate 
    for (i=0; i<height; i = i+2) begin 
        for (j=0; j<width; j = j+2) begin 
            avg ag(
                    .a (in[(i*height+j)*16 +: 16]),
                    .b (in[(i*height+j+1)*16 +: 16]),
                    .c (in[((i+1)*height+j)*16 +: 16]),
                    .d (in[((i+1)*height+j+1)*16 +: 16]),
                    .avgout (out[(i*height/4+j/2)*16 +: 16])
                   );
        end
    end 
endgenerate
endmodule


