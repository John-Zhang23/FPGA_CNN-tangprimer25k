module biasadd
#(
parameter width = 28,
parameter height = 28
)
(
input [0:15] bias,
input [0:16*width*height-1] matrix_in,
output reg [0:16*width*height-1] matrix_out
);

genvar i,j;

generate
        for (i=0;i<width;i=i+1) begin
            for (j=0;j<width;j=j+1) begin
                floatAdd(
                        .floatA (matrix_in[(i*height+j)*16 +: 16]),
                        .floatB (bias),
                        .sum (matrix_out[(i*height+j)*16 +: 16])
                        );
        end
    end 
endgenerate


endmodule