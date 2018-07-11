module roundOps_plus_hashReg_tb;
  
  localparam WORD_SIZE=32,ROUNDS=64;
  integer init_file, message_file, out_file;
  
  reg [WORD_SIZE:1] message_schedule[ROUNDS-1:0];
  reg input_ready;
  reg clock;
  always #10 clock = ~clock;
  reg clear;
  
  wire [WORD_SIZE:1] message_schedule_value;
  wire [WORD_SIZE*8-1:0] H;
  
  roundOps_plus_hashReg ro_hr(H, message_schedule_value, clock, input_ready, clear);
  
  
  
  
endmodule
