module Hash_Register(H, clk, we, reset, a, b, c, d, e, f, g, h);
input clk, we, reset; // reset is synchronize and active high
input [31:0] a, b, c, d, e, f, g, h; // a is H[0], b is H[1], c is H[2] ... h is H[7]
output [32*8-1:0] H; //Output hashed
reg [31:0] h0, h1, h2, h3, h4, h5, h6, h7; //registers which contain hash values
wire [31:0] w0, w1, w2, w3, w4, w5, w6, w7; // wires wich connect adder to register
initial
    begin
    // initial value of hash registers
    // values are derived from follow resource:
    //                      https://csrc.nist.gov/csrc/media/publications/fips/180/4/final/documents/fips180-4-draft-aug2014.pdf
    h0 = 32'h6a09e667;
    h1 = 32'hbb67ae85;
    h2 = 32'h3c6ef372;
    h3 = 32'ha54ff53a;
    h4 = 32'h510e527f;
    h5 = 32'h9b05688c;
    h6 = 32'h1f83d9ab;
    h7 = 32'h5be0cd19;
    end
//assign output to saved registers
assign H = {h0, h1, h2, h3, h4, h5, h6, h7};
adder32 adder1(a, h0, w0);
adder32 adder2(b, h1, w1);
adder32 adder3(c, h2, w2);
adder32 adder4(d, h3, w3);
adder32 adder5(e, h4, w4);
adder32 adder6(f, h5, w5);
adder32 adder7(g, h6, w6);
adder32 adder8(h, h7, w7);

always @(posedge clk)
    begin
    if (reset)
        begin
        // restore registers to initial values
        h0 = 32'h6a09e667;
        h1 = 32'hbb67ae85;
        h2 = 32'h3c6ef372;
        h3 = 32'ha54ff53a;
        h4 = 32'h510e527f;
        h5 = 32'h9b05688c;
        h6 = 32'h1f83d9ab;
        h7 = 32'h5be0cd19;
        end
    else
    begin
        // if writing is enable:
        if (we)
        begin
        //add new H values to recent values and save them in H again
        h0 = w0;
        h1 = w1;
        h2 = w2;
        h3 = w3;
        h4 = w4;
        h5 = w5;
        h6 = w6;
        h7 = w7;
        end
    end
    end
endmodule 