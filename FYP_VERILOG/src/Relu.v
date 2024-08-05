module Relu
#(
parameter width = 28,
parameter height = 28,
parameter depth = 6
)
(
input clk,rst,
input [0:16*width*height*depth-1] matrix_in,
output reg [0:16*width*height*depth-1] matrix_out
);

integer cnt,j,k;

always @(posedge clk or posedge rst) begin 
if (rst == 1'b1) cnt =0;
else if(cnt < depth) cnt = cnt+1;
end

always @(*) begin
     for (j=0; j<height; j=j+1) begin 
         for (k=0; k<width; k=k+1) begin 
             matrix_out[(cnt*height*width+j*height+k)*16 +: 16] = (matrix_in[(cnt*height*width+j*height+k)*16]==1)? 16'h0000 : matrix_in[(cnt*height*width+j*height+k)*16 +: 16];
         end
     end
end

endmodule 