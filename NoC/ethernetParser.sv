module ethernetParser #(parameter WIDTH = 8)
  (input logic clk, rst_n,
   input logic [(WIDTH-1):0] data_in,
   input logic data_valid,
   input logic sop, eop,
   input logic ready,
   output logic [(WIDTH*6)-1:0] dest_mac, src_mac,
   output logic [(WIDTH*2)-1:0] ethertype,
   output logic header_valid,
   output logic [(WIDTH-1):0] payload_data,
   output logic payload_valid, error);
  
  logic [4:0] byte_count;
  logic [(WIDTH*6)-1:0] shift_reg_mac;
  logic [(WIDTH*2)-1:0] shift_reg_type;
  
  typedef enum logic [1:0] {IDLE, RECEIVE_HEADER, PAYLOAD, DONE} state_t;
  state_t current_state;
  state_t next_state;
  
  always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end
  
  always_comb begin
    next_state = current_state;
    case(current_state)
      IDLE: 
        if(sop && data_valid && ready) begin
          next_state = RECEIVE_HEADER;
        end else 
          next_state = IDLE;
      
      RECEIVE_HEADER:
        if(eop && byte_count < 13) 
          next_state = DONE;
      
      else if(data_valid && byte_count == 13)
        next_state = PAYLOAD;
      
      else 
        next_state = RECEIVE_HEADER;
            
      PAYLOAD:
            if(eop)
                  next_state = DONE;
            else
                next_state = PAYLOAD;
            
      
      DONE:
          next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end
  
endmodule 
