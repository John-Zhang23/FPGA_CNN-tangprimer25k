module zero_padding 
#(
parameter width = 28,
parameter height = 28,
parameter padding = 2
)
(
input [0:16*width*height-1] matrix_in,
output reg [0:16*(width+padding*2)*(height+padding*2)-1] matrix_out =0
);

integer i,j;

always @(*) begin
        for (i=0;i<width;i=i+1) begin
            for (j=0;j<width;j=j+1) begin
                matrix_out[((i+padding)*(width+padding*padding)+j+padding)*16 +: 16] = matrix_in[(i*height+j)*16 +: 16];
        end
    end 
end 


endmodule