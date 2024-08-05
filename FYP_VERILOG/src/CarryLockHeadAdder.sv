module add_8_1(
    input wire [7:0] add1,
    input wire [7:0] add2,
    input wire cin,
    output wire [7:0] sum,
    output wire cout
    );
    wire[7:0] g,p,c;
    assign c[0]=cin;
    assign p=add1 ^ add2;
    assign g=add1 & add2;
    assign c[0] = g[0]|(p[0]&c[0]);
    assign c[1] = g[1]|(p[1]&(g[0]|(p[0] & c[0])));
    assign c[2] = g[2]|(p[2]&(g[1]|(p[1] & (g[0] | (p[0] & c[0])))));
    assign c[3] = g[3]|(p[3]&(g[2]|(p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))));
    assign c[4] = g[4]|(p[4]&(g[3]|(p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))));
    assign c[5] = g[5]|(p[5]&(g[4]|(p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))));
    assign c[6] = g[6]|(p[6]&(g[5]|(p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))));
    assign c[7] = g[7]|(p[7]&(g[6]|(p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))));
    assign sum=p^c[7:0];
    assign cout=c[7];
endmodule