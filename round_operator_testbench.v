module round_operator_testbench();
  parameter WORD_SIZE=32;
  integer in_file, out_file;
  wire [WORD_SIZE:1] a_ans,
                     b_ans,
                     c_ans,
                     d_ans,
                     e_ans,
                     f_ans,
                     g_ans,
                     h_ans;
  reg [WORD_SIZE:1] working_variable[7:0];
  reg [WORD_SIZE:1] constant;
  reg [WORD_SIZE:1] message_register_value;
  
  reg [WORD_SIZE:1] temp;
    
  wire [7:0] check;
  assign check[0] = ( temp == a_ans );
  assign check[1] = ( temp == b_ans );
  assign check[2] = ( temp == c_ans );
  assign check[3] = ( temp == d_ans );
  assign check[4] = ( temp == e_ans );
  assign check[5] = ( temp == f_ans );
  assign check[6] = ( temp == g_ans );
  assign check[7] = ( temp == h_ans );
  
  round_operator rr(a_ans,
                    b_ans,
                    c_ans,
                    d_ans,
                    e_ans,
                    f_ans,
                    g_ans,
                    h_ans,
                    working_variable[0],
                    working_variable[1],
                    working_variable[2],
                    working_variable[3],
                    working_variable[4],
                    working_variable[5],
                    working_variable[6],
                    working_variable[7],
                    message_register_value,
                    constant
                    );
  
  integer i, test_case;
  initial begin
    in_file = $fopen("input.txt", "r");
    out_file = $fopen("output.txt", "r");
    for (test_case=0; test_case < 10; test_case = test_case+1) begin
      for ( i=0; i < 8; i= i+1) begin
        $fscanf(in_file, "%x", working_variable[i]);
        //$display("display %d", working_variable[i]);
      end
      $fscanf(in_file, "%x", message_register_value);
      $fscanf(in_file, "%x", constant);
      #10
      /*
        $display("test %x",  a_ans);
        $display("test %x",  b_ans);
        $display("test %x", c_ans);
        $display("test %x",  d_ans);
        $display("test %x",  e_ans);
        $display("test %x", f_ans);
        $display("test %x",  g_ans);
        $display("test %x",  h_ans); */
      for ( i=0; i < 8; i= i+1) begin
        #10
        $fscanf(out_file, "%x", temp);
        #10
        //$display("test %d %x", i, temp);
        $display("test %d : %d", test_case, check[i]);
      end
      $fscanf(out_file, "%x", temp);
      $fscanf(out_file, "%x", temp);
    
    end
  end

endmodule