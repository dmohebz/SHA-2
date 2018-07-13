module roundOps_plus_hashReg #(parameter WORD_SIZE=32, ROUNDS=64)(
  
  output [WORD_SIZE*8-1:0] H, //Output hashed
  output [clogb2(ROUNDS):1] message_schedule_index,
  
  input [WORD_SIZE:1] message_schedule_value,
  input clock,
  input input_ready,
  input clear,
  
  input reset
);

wire [WORD_SIZE:1] a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final;
wire output_ready;

wire [WORD_SIZE:1] a_init, b_init, c_init, d_init, e_init, f_init, g_init, h_init;
assign a_init = H[32*8-1:32*7];
assign b_init = H[32*7-1:32*6];
assign c_init = H[32*6-1:32*5];
assign d_init = H[32*5-1:32*4];
assign e_init = H[32*4-1:32*3];
assign f_init = H[32*3-1:32*2];
assign g_init = H[32*2-1:32*1];
assign h_init = H[32*1-1:32*0];

round_operations ro(a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final,
                      message_schedule_index,
                      output_ready,
                      a_init,b_init,c_init,d_init,e_init,f_init,g_init,h_init,
                      message_schedule_value,
                      clock,
                      input_ready,
                      clear
);

Hash_Register hr(H, clock, output_ready, reset, a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final);

function integer clogb2;
    input [31:0] value; begin 
        value = value - 1;
        for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
            value = value >> 1;
        end
    end
endfunction

endmodule