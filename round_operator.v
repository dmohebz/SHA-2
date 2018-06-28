module round_operator #(parameter WORD_SIZE = 32) (
  output [WORD_SIZE:1] a_next,
  output [WORD_SIZE:1] b_next,
  output [WORD_SIZE:1] c_next,
  output [WORD_SIZE:1] d_next,
  output [WORD_SIZE:1] e_next,
  output [WORD_SIZE:1] f_next,
  output [WORD_SIZE:1] g_next,
  output [WORD_SIZE:1] h_next,
  input [WORD_SIZE:1] a_prev,
  input [WORD_SIZE:1] b_prev,
  input [WORD_SIZE:1] c_prev,
  input [WORD_SIZE:1] d_prev,
  input [WORD_SIZE:1] e_prev,
  input [WORD_SIZE:1] f_prev,
  input [WORD_SIZE:1] g_prev,
  input [WORD_SIZE:1] h_prev,
  input [WORD_SIZE:1] message_schedule_value,
  input [WORD_SIZE:1] constant_value
  );
  
  wire [WORD_SIZE:1] T_1 =   h_prev
            + Sigma_1(e_prev)
            + Ch(e_prev, f_prev, g_prev)
            + constant_value
            + message_schedule_value;
  
  wire [WORD_SIZE:1] T_2 =   Sigma_0(a_prev)
            + Maj(a_prev, b_prev, c_prev);
  
  assign h_next = g_prev, //h = g
  g_next = f_prev, //g = f
  f_next = e_prev, //f = e
  e_next = d_prev + T_1, //e = d + T_1
  d_next = c_prev, // d = c
  c_next = b_prev, // c = b
  b_next = a_prev, // b = a
  a_next = T_1 + T_2; // a = T_1 + T_2
  
  function [WORD_SIZE:1] Ch;
    input [WORD_SIZE:1] x, y, z;
    Ch = (x & y) ^ (~x & z);
  endfunction
  
  function [WORD_SIZE:1] Maj;
    input [WORD_SIZE:1] x, y, z;
    Maj = (x & y) ^ (x & z) ^ (y & z);
  endfunction
  
  function [WORD_SIZE:1] Sigma_0;
    input [WORD_SIZE:1] x;
    Sigma_0 =   ( {x[2:1], x[WORD_SIZE:3]} ) 
              ^ ( {x[13:1], x[WORD_SIZE:14]} ) 
              ^ ( {x[22:1], x[WORD_SIZE:23]} );
  endfunction
  
  function [WORD_SIZE:1] Sigma_1;
    input [WORD_SIZE:1] x;
    Sigma_1 =   ( {x[6:1], x[WORD_SIZE:7]} ) 
              ^ ( {x[11:1], x[WORD_SIZE:12]} ) 
              ^ ( {x[25:1], x[WORD_SIZE:26]} );
  endfunction
  
endmodule