module roundOps_plus_hashReg_tb;
  
  localparam WORD_SIZE=32,ROUNDS=64;
  integer init_file, message_file, out_file;
  
  reg [WORD_SIZE:1] message_schedule[ROUNDS-1:0];
  reg input_ready;
  reg clock;
  always #10 clock = ~clock;
  reg clear;
  
  reg reset;
  
  wire [WORD_SIZE*8-1:0] H;
   
  wire [clogb2(ROUNDS):1] message_schedule_index;
  wire [WORD_SIZE:1] message_schedule_value;
  assign message_schedule_value = message_schedule[message_schedule_index];
  
  roundOps_plus_hashReg ro_hr(H, message_schedule_index, message_schedule_value, clock, input_ready, clear, reset);
  
  
  integer test_case,j;
  wire [WORD_SIZE:1] temp;
  reg a = 1;
  
  initial begin
    clock = 1'b0;
    clear = 1'b0;
    reset = 1'b0;
    input_ready = 1'b0;
    #1
    clear = 1'b1;
    reset = 1'b1;
    #10
    clear = 1'b0;
    reset = 1'b0;
    message_file = $fopen("input_message_registers.txt", "r");
    out_file = $fopen("output_round_operations.txt", "r");
    
    for (test_case = 0; test_case < 1; test_case = test_case + 1) begin
      
      for ( j = 0; j < 64; j = j+1 ) begin 
        $fscanf(message_file, "%x", message_schedule[j]);
      end
      #1
      input_ready = 1;
      
      $display("%h", H);
      
      #50
      $display("%h", H);
      
      #20
      input_ready = 0;
      
      #1500
      $display("%h", H);
      
      
    end
    
    $stop;
    
  end
  
  function integer clogb2;
    input [31:0] value; begin 
        value = value - 1;
        for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
            value = value >> 1;
        end
    end
  endfunction
  
  
endmodule
