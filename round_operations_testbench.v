module round_operations_testbench;
  localparam WORD_SIZE=32,ROUNDS=64;
  integer init_file, message_file, out_file;
  
  wire [WORD_SIZE:1] a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final;
  wire [clogb2(ROUNDS):1] message_schedule_index;
  wire output_ready;
  
  reg [WORD_SIZE:1] a_init,b_init,c_init,d_init,e_init,f_init,g_init,h_init;
  reg [WORD_SIZE:1] message_schedule[ROUNDS-1:0];
  reg input_ready;
  reg clock;
  always #10 clock = ~clock;
  reg clear;
  
  wire [WORD_SIZE:1] message_schedule_value;
  assign message_schedule_value = message_schedule[message_schedule_index];
  
  round_operations rr(a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final,
                      message_schedule_index,
                      output_ready,
                      a_init,b_init,c_init,d_init,e_init,f_init,g_init,h_init,
                      message_schedule_value,
                      clock,
                      input_ready,
                      clear
  );
  
  integer test_case,j;
  wire [WORD_SIZE:1] temp;
  reg a = 1;
  
  initial begin
    clock = 1'b0;
    clear = 1'b0;
    input_ready = 1'b0;
    #1
    clear = 1'b1;
    #10
    clear = 1'b0;
    init_file = $fopen("input_initial_working_variables.txt","r");
    message_file = $fopen("input_message_registers.txt", "r");
    out_file = $fopen("output_round_operations.txt", "r");
    
    for (test_case = 0; test_case < 1; test_case = test_case + 1) begin
      $fscanf(init_file, "%x", a_init);
      $fscanf(init_file, "%x", b_init);
      $fscanf(init_file, "%x", c_init);
      $fscanf(init_file, "%x", d_init);
      $fscanf(init_file, "%x", e_init);
      $fscanf(init_file, "%x", f_init);
      $fscanf(init_file, "%x", g_init);
      $fscanf(init_file, "%x", h_init);
      for ( j = 0; j < 64; j = j+1 ) begin 
        $fscanf(message_file, "%x", message_schedule[j]);
      end
      #1
      input_ready = 1;
      #20
      input_ready = 0;
      
      //while(~output_ready) a = 1;
      a = 1;
      #700
      
      $fscanf(out_file, "%x", temp);
      if (temp != a_final) begin
        $display("Test failed at a");
        a = 0;
      end
        
      $fscanf(out_file, "%x", temp);
      if (temp != b_final) begin
        $display("Test failed at b");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != c_final) begin
        $display("Test failed at c");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != d_final) begin
        $display("Test failed at d");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != e_final) begin
        $display("Test failed at e");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != f_final) begin
        $display("Test failed at f");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != g_final) begin
        $display("Test failed at g");
        a = 0;
      end
      
      $fscanf(out_file, "%x", temp);
      if (temp != h_final) begin
        $display("Test failed at h");
        a = 0;
      end
      
      if (a) begin
        $display("Test Succeeded!");
      end
      
      
    end
    
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