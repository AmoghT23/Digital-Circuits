//MESI Protocol

typedef enum logic [1:0] {
  I = 2'b00,
  S = 2'b01,
  E = 2'b10,
  M = 2'b11
} mesi_state_t;

module mesi(input logic clk, reset,
            input logic proc_read, proc_write, snoop_read, snoop_invalidate,
            input logic shared_hit,
            output logic read_from_L2,
            output logic write_to_L2,
            output logic return_data_to_L2,
            output mesi_state_t state_out
           );
  
  mesi_state_t state, next_state;
  
  always_comb begin 
    read_from_L2 = 0;
    write_to_L2 = 0;
    return_data_to_L2 = 0;
    next_state = state;
    
    unique case(state)
      
      I: begin
        if(proc_read) begin
          read_from_L2 = 1;
          next_state = shared_hit ? S:E;
        end
        else if (proc_write) begin
          read_from_L2 = 1;
          next_state = M;
        end
      end
      
      S:begin
        if(proc_write) begin
          read_from_L2 = 1;
          next_state = M;
        end
        else if (snoop_invalidate) begin
          next_state = I;
        end
      end
      
      E:begin
        if(proc_write) begin
          read_from_L2 = 1;
          next_state = M;
        end
        else if(snoop_read) begin
          next_state = I;
        end 
      end
      
      M:begin
        if(snoop_read) begin
          return_data_to_L2 = 1;
          write_to_L2 = 1;
          next_state = S;
        end
        else if(snoop_invalidate) begin
          write_to_L2 = 1;
          next_state = I;
        end
      end
    endcase
  end
  
  always_ff @(posedge clk or negedge clk) begin
    if(reset)
      state<=I;
    else
      state<=next_state;
  end
  
  assign state_out = state;
endmodule
