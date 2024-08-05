

/*module conv_one 
#(
parameter k_size = 5,
parameter width = 32,
parameter height = 32,
parameter stride = 1
)
(
input clk,rst,
input [15:0] kernel[0:k_size-1][0:k_size-1],
input [15:0] in[0:height-1][0:width-1],
output reg [15:0] out [0:(height-k_size)/stride][0:(width-k_size)/stride]
);

reg cnt_i_flag;
integer cnt_i,cnt_j,m,n;
reg [15:0] in_slice[0:k_size-1][0:k_size-1];
wire [15:0] out_s;


always @(posedge clk or posedge rst) begin 
	if (rst == 1'b1) begin 
		cnt_j <=0;
	end	
	else if(cnt_j == ((width-k_size)/stride+1)) begin 
		cnt_j <=0;
		cnt_i_flag <=1;
	end
	else begin 
		cnt_j <= cnt_j +1;
		cnt_i_flag <=0;
	end
end

always @(posedge cnt_i_flag or posedge rst) begin 
	if (rst == 1'b1) begin 
		cnt_i <=0;
	end	
	else if(cnt_i == ((height-k_size)/stride+1)) begin 
		cnt_i <=0;
	end
	else begin 

		cnt_i <= cnt_i +1;
	end
end

always @(*) begin
	for (m=0;m<k_size;m=m+1) begin
  	 for (n=0;n<k_size;n=n+1) begin
       	  in_slice[m][n] = in[cnt_i*stride+m][cnt_j*stride+n];
   	 end
	end
    out[cnt_i][cnt_j] = out_s;
end


convunit 
  #(
   .k_size(k_size)
   ) 
conunit0
   (
   .in (in_slice),
   .kernel(kernel),
   .out (out_s)
   );
endmodule



/*module conv_one 
#(
parameter k_size = 5,
parameter width = 28,
parameter height = 28,
parameter padding = 2,
parameter stride = 1
)
(
input clk,rst,
input [15:0] kernel[0:k_size-1][0:k_size-1],
input [15:0] in[0:height+padding+padding-1][0:width+padding+padding-1],
output reg [15:0] out [0:(height+padding+padding-k_size)/stride+1-1][0:(width+padding+padding-k_size)/stride+1-1]
);
integer cnt_i,cnt_j;
wire [15:0] in_slice[0:k_size-1][0:k_size-1];
wire [15:0] out_s [0:(width+padding+padding-k_size)/stride];

always @(posedge clk or posedge rst) begin 
if (rst == 1'b1) begin 
cnt_i <=0;
end
else if(cnt < ((height+padding+padding-k_size)/stride+1)) cnt <= cnt+1;
end

reg [15:0] product [0:k_size-1] [0:k_size-1];
reg [15:0] sum [0:k_size*k_size];
assign sum[0] = 16'b0;
assign out = sum [k_size*k_size];
genvar i,j,ki,kj;

generate 
for (i=0; i<(height+padding+padding-k_size)/stride ; i=i+1) begin
  for (j=0; j<(height+padding+padding-k_size)/stride; j=j+1) begin
    for (ki=0; ki<k_size; ki=ki+1) begin
      for (kj=0; kj<k_size; kj=kj+1) begin
            floatMult fmult(
            .floatA (in[i*stride+ki][j*stride+kj]), 
            .floatB (kernel[ki][kj]),
            .product (product[i][j])
            );
            floatAdd fad (
            .floatA (product[i][j]),
            .floatB (sum[i*k_size+j]),
            .sum (sum[i*k_size+j+1])
            );
      end
    end
  end
end

endgenerate 
endmodule
*/




/*
genvar i,m,n;
generate 
    	for (i=0;i<((width+padding+padding-k_size)/stride+1);i=i+1) begin 
            for (m=0; m<k_size;m=m+1) begin
                for (n=0; n<k_size;n=n+1) begin
                    assign in_slice[m][n] = in[cnt*stride+m][i*stride+n];
             end
        end
        convunit 
        #(
        .k_size(k_size)
        ) 
	conunit0
        (
        .in (in_slice),
        .kernel(kernel),
        .out (out[cnt][i])
        );
    end
endgenerate
endmodule*/



/*
reg [15:0] in_a [0:k_size-1] [0:width+padding+padding-1];

always @(*) begin
for (j=0;j<k_size;i =j+1) begin
    for (k=0; k<k_size; k=k+1) begin 
        in_a[j] = in[cnt*stride]
    end
end
end */




/*module conv_one 
#(
parameter k_size = 5,
parameter width = 32,
parameter height = 32,
parameter stride = 1
)
(
input clk,rst,
input [15:0] kernel[0:k_size-1][0:k_size-1],
input [15:0] in[0:height-1][0:width-1],
output reg [15:0] out [0:(height-k_size)/stride][0:(width-k_size)/stride]
);

reg cnt_i_flag;
integer cnt_i,cnt_j,m,n;
reg [15:0] in_slice[0:k_size-1][0:k_size-1];
wire [15:0] out_s;


always @(posedge clk or posedge rst) begin 
	if (rst == 1'b1) begin 
		cnt_j <=0;
	end	
	else if(cnt_j == ((width-k_size)/stride)) begin 
		cnt_j <=0;
		cnt_i_flag <=1;
	end
	else begin 
		cnt_j <= cnt_j +1;
		cnt_i_flag <=0;
	end
end

always @(posedge cnt_j or posedge rst) begin 
	if (rst == 1'b1) begin 
		cnt_i <=0;
	end	
	else if(cnt_i == ((width-k_size)/stride)) begin 
		cnt_i <=0;
	end
	else begin 
		cnt_i <= cnt_i +1;
	end
end

always @(*) begin

	for (m=0;m<k_size;m=m+1) begin
  	 for (n=0;n<k_size;n=n+1) begin
       	  in_slice[m][n] = in[cnt_i*stride+m][cnt_j*stride+n];
   	 end
	end

	out[cnt_i][cnt_j] = out_s;
end


convunit 
  #(
   .k_size(k_size)
   ) 
conunit0
   (
   .in (in_slice),
   .kernel(kernel),
   .out (out_s)
   );
endmodule



/*module conv_one 
#(
parameter k_size = 5,
parameter width = 28,
parameter height = 28,
parameter padding = 2,
parameter stride = 1
)
(
input clk,rst,
input [15:0] kernel[0:k_size-1][0:k_size-1],
input [15:0] in[0:height+padding+padding-1][0:width+padding+padding-1],
output reg [15:0] out [0:(height+padding+padding-k_size)/stride+1-1][0:(width+padding+padding-k_size)/stride+1-1]
);
integer cnt_i,cnt_j;
wire [15:0] in_slice[0:k_size-1][0:k_size-1];
wire [15:0] out_s [0:(width+padding+padding-k_size)/stride];

always @(posedge clk or posedge rst) begin 
if (rst == 1'b1) begin 
cnt_i <=0;
end
else if(cnt < ((height+padding+padding-k_size)/stride+1)) cnt <= cnt+1;
end

reg [15:0] product [0:k_size-1] [0:k_size-1];
reg [15:0] sum [0:k_size*k_size];
assign sum[0] = 16'b0;
assign out = sum [k_size*k_size];
genvar i,j,ki,kj;

generate 
for (i=0; i<(height+padding+padding-k_size)/stride ; i=i+1) begin
  for (j=0; j<(height+padding+padding-k_size)/stride; j=j+1) begin
    for (ki=0; ki<k_size; ki=ki+1) begin
      for (kj=0; kj<k_size; kj=kj+1) begin
            floatMult fmult(
            .floatA (in[i*stride+ki][j*stride+kj]), 
            .floatB (kernel[ki][kj]),
            .product (product[i][j])
            );
            floatAdd fad (
            .floatA (product[i][j]),
            .floatB (sum[i*k_size+j]),
            .sum (sum[i*k_size+j+1])
            );
      end
    end
  end
end

endgenerate 
endmodule
*/




/*
genvar i,m,n;
generate 
    	for (i=0;i<((width+padding+padding-k_size)/stride+1);i=i+1) begin 
            for (m=0; m<k_size;m=m+1) begin
                for (n=0; n<k_size;n=n+1) begin
                    assign in_slice[m][n] = in[cnt*stride+m][i*stride+n];
             end
        end
        convunit 
        #(
        .k_size(k_size)
        ) 
	conunit0
        (
        .in (in_slice),
        .kernel(kernel),
        .out (out[cnt][i])
        );
    end
endgenerate
endmodule*/



/*
reg [15:0] in_a [0:k_size-1] [0:width+padding+padding-1];

always @(*) begin
for (j=0;j<k_size;i =j+1) begin
    for (k=0; k<k_size; k=k+1) begin 
        in_a[j] = in[cnt*stride]
    end
end
end */

