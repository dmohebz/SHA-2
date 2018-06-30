module adder32_tb;
reg [31:0] input1, input2;
wire [31:0] result;

adder32 my_adder_test(input1, input2, result);
initial
begin
	input1 = 32'd0;
	input2 = 32'd0;
	#5
	input1 = 32'd1;
	input2 = 32'd0;
	#5
	input1 = 32'd5;
	input2 = 32'd10;
	#5
	input1 = 32'd124;
	input2 = 32'd1237;
	#5
	input1 = 32'h10101010;
	input2 = 32'h4ABFFFFF;
end
initial
$monitor($time, " , input1_binary: %b, input2_binary: %b, result_binary: %b   , input1_decimal: %d, input2_decimal: %d, result_decimal: %d", input1,input2, result, input1, input2, result);

endmodule
