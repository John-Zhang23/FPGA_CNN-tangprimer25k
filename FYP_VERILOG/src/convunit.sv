module convunit
#(
    parameter k_size = 5
)
(
input [15:0] in [0:k_size-1] [0:k_size-1],
input [15:0] kernel [0:k_size-1] [0:k_size-1],
output [15:0] out
);

reg [15:0] product [0:k_size-1] [0:k_size-1];
reg [15:0] sum [0:k_size*k_size];
assign sum[0] = 16'b0;
assign out = sum [k_size*k_size];
genvar i,j;


generate 
    for (i=0; i<k_size; i=i+1) begin
        for (j=0; j<k_size; j=j+1) begin

            floatMult fmult(
            .floatA (in[i][j]), 
            .floatB (kernel[i][j]),
            .product (product[i][j])
            );

            floatAdd fad (
            .floatA (product[i][j]),
            .floatB (sum[i*k_size+j]),
            .sum (sum[i*k_size+j+1])
            );

        end
    end
endgenerate 
endmodule