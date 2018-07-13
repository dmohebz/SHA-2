module round_operations #(parameter WORD_SIZE=32, ROUNDS=64)(
  output reg [WORD_SIZE:1] a_final,
  output reg [WORD_SIZE:1] b_final,
  output reg [WORD_SIZE:1] c_final,
  output reg [WORD_SIZE:1] d_final,
  output reg [WORD_SIZE:1] e_final,
  output reg [WORD_SIZE:1] f_final,
  output reg [WORD_SIZE:1] g_final,
  output reg [WORD_SIZE:1] h_final,
  output [clogb2(ROUNDS):1] message_schedule_index,
  output output_ready,
  
  input [WORD_SIZE:1] a_init,
  input [WORD_SIZE:1] b_init,
  input [WORD_SIZE:1] c_init,
  input [WORD_SIZE:1] d_init,
  input [WORD_SIZE:1] e_init,
  input [WORD_SIZE:1] f_init,
  input [WORD_SIZE:1] g_init,
  input [WORD_SIZE:1] h_init,
  input [WORD_SIZE:1] message_schedule_value,
  input clock,
  input input_ready,
  input clear
);
localparam IDLE=2'b00, BUSY=2'b01, DONE=2'b10;
wire [WORD_SIZE:1] a;
wire [WORD_SIZE:1] b;
wire [WORD_SIZE:1] c;
wire [WORD_SIZE:1] d;
wire [WORD_SIZE:1] e;
wire [WORD_SIZE:1] f;
wire [WORD_SIZE:1] g;
wire [WORD_SIZE:1] h;

reg [clogb2(ROUNDS)+1:1] cnt;
reg [1:0] state;
wire [WORD_SIZE:1] constant[ROUNDS-1:0];
wire [WORD_SIZE:1] constant_selector;

round_operator rr(a,b,c,d,e,f,g,h,
                  a_final, b_final, c_final, d_final, e_final, f_final, g_final, h_final,
                  message_schedule_value,
                  constant_selector
);
assign constant_selector = constant[cnt];
assign message_schedule_index = cnt[6:1];
assign output_ready = (state == DONE);

always @(posedge clock or posedge clear) begin
  if (clear) begin
    state <= IDLE;
    cnt <= 0;
  end
  else
  case (state)
    IDLE: if (input_ready)
            begin
              cnt <= 0;
              state <= BUSY;
              a_final <= a_init;
              b_final <= b_init;
              c_final <= c_init;
              d_final <= d_init;
              e_final <= e_init;
              f_final <= f_init;
              g_final <= g_init;
              h_final <= h_init;
            end
    BUSY: 
              if (cnt == 64) begin
                state <= DONE;
                $display("64 marhale passed");
              end
              else
                begin
                a_final <= a;
                b_final <= b;
                c_final <= c;
                d_final <= d;
                e_final <= e;
                f_final <= f;
                g_final <= g;
                h_final <= h;
                cnt <= cnt + 7'b1;
                $display("%d", cnt);
                end
          
    DONE: state = IDLE;
  endcase
end


function integer clogb2;
    input [31:0] value; begin 
        value = value - 1;
        for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1) begin
            value = value >> 1;
        end
    end
endfunction

  assign constant[0]=32'h428a2f98;
  assign constant[1]=32'h71374491;
  assign constant[2]=32'hb5c0fbcf;
  assign constant[3]=32'he9b5dba5;
  assign constant[4]=32'h3956c25b;
  assign constant[5]=32'h59f111f1;
  assign constant[6]=32'h923f82a4;
  assign constant[7]=32'hab1c5ed5;
  assign constant[8]=32'hd807aa98;
  assign constant[9]=32'h12835b01;
  assign constant[10]=32'h243185be;
  assign constant[11]=32'h550c7dc3;
  assign constant[12]=32'h72be5d74;
  assign constant[13]=32'h80deb1fe;
  assign constant[14]=32'h9bdc06a7;
  assign constant[15]=32'hc19bf174;
  assign constant[16]=32'he49b69c1;
  assign constant[17]=32'hefbe4786;
  assign constant[18]=32'h0fc19dc6;
  assign constant[19]=32'h240ca1cc;
  assign constant[20]=32'h2de92c6f;
  assign constant[21]=32'h4a7484aa;
  assign constant[22]=32'h5cb0a9dc;
  assign constant[23]=32'h76f988da;
  assign constant[24]=32'h983e5152;
  assign constant[25]=32'ha831c66d;
  assign constant[26]=32'hb00327c8;
  assign constant[27]=32'hbf597fc7;
  assign constant[28]=32'hc6e00bf3;
  assign constant[29]=32'hd5a79147;
  assign constant[30]=32'h06ca6351;
  assign constant[31]=32'h14292967;
  assign constant[32]=32'h27b70a85;
  assign constant[33]=32'h2e1b2138;
  assign constant[34]=32'h4d2c6dfc;
  assign constant[35]=32'h53380d13;
  assign constant[36]=32'h650a7354;
  assign constant[37]=32'h766a0abb;
  assign constant[38]=32'h81c2c92e;
  assign constant[39]=32'h92722c85;
  assign constant[40]=32'ha2bfe8a1;
  assign constant[41]=32'ha81a664b;
  assign constant[42]=32'hc24b8b70;
  assign constant[43]=32'hc76c51a3;
  assign constant[44]=32'hd192e819;
  assign constant[45]=32'hd6990624;
  assign constant[46]=32'hf40e3585;
  assign constant[47]=32'h106aa070;
  assign constant[48]=32'h19a4c116;
  assign constant[49]=32'h1e376c08;
  assign constant[50]=32'h2748774c;
  assign constant[51]=32'h34b0bcb5;
  assign constant[52]=32'h391c0cb3;
  assign constant[53]=32'h4ed8aa4a;
  assign constant[54]=32'h5b9cca4f;
  assign constant[55]=32'h682e6ff3;
  assign constant[56]=32'h748f82ee;
  assign constant[57]=32'h78a5636f;
  assign constant[58]=32'h84c87814;
  assign constant[59]=32'h8cc70208;
  assign constant[60]=32'h90befffa;
  assign constant[61]=32'ha4506ceb;
  assign constant[62]=32'hbef9a3f7;
  assign constant[63]=32'hc67178f2;



endmodule