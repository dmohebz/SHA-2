module Hash_Register_tb;
reg clk, we, reset;
reg [31:0] a,b,c,d,e,f,g,h;
wire [32*8-1:0] H;

initial
begin
clk = 1'b0;
we = 1'b0;
reset = 1'b0;
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd0;
g = 32'd0;
h = 32'd1;
#20
we = 1'b1;
#10
a = 32'd0;
b = 32'd1;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd0;
g = 32'd0;
h = 32'd0;
#10
a = 32'd0;
b = 32'd0;
c = 32'd1;
d = 32'd0;
e = 32'd0;
f = 32'd0;
g = 32'd0;
h = 32'd0;

#10
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd1;
e = 32'd0;
f = 32'd0;
g = 32'd0;
h = 32'd0;

#10
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd1;
f = 32'd0;
g = 32'd0;
h = 32'd0;

#10
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd1;
g = 32'd0;
h = 32'd0;

#10
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd0;
g = 32'd1;
h = 32'd0;

#10
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd5;
g = 32'd0;
h = 32'd10;

#10
a = 32'd10;
b = 32'd11;
c = 32'd12;
d = 32'd13;
e = 32'd14;
f = 32'd15;
g = 32'd16;
h = 32'd17;

#5
reset = 1'b1;
#20
a = 32'd0;
b = 32'd0;
c = 32'd0;
d = 32'd0;
e = 32'd0;
f = 32'd0;
g = 32'd0;
h = 32'd1;


end
always
#5 clk = ~clk;

Hash_Register my_hr (H, clk, we, reset, a, b, c, d, e, f, g, h);
endmodule
