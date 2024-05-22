module avg(
input [15:0] a,b,c,d,
output [15:0] avgout
);
wire [15:0] out1,out2,out3;
reg [15:0] qrter = 16'h3400; //0.25

floatAdd avg_add0 (
.floatA (a),
.floatB (b),
.sum (out1)
);
floatAdd avg_add1 (
.floatA (c),
.floatB (d),
.sum (out2)
);
floatAdd avg_add2 (
.floatA (out1),
.floatB (out2),
.sum (out3)
);
floatMult avg_mult0(

.floatA  (out3),
.floatB  (qrter),
.product (avgout)
);
endmodule

