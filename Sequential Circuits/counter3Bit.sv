//--------------------------- Design ---------------------------//
module counter3Bit(input logic clock, rst_p,
                   output logic [2:0]counter);
  
  
  typedef enum logic [2:0] {c0,c1,c2,c3,c4,c5,c6,c7} state_t;
  state_t current_state, next_state;
  assign counter = current_state;
  
  always_ff @(posedge clock or posedge rst_p) begin
    if(rst_p) 
      current_state <= c0;
    else 
      current_state <= next_state;
  end
  
  always_comb begin 
    next_state = current_state;
    
    
    case(current_state)
      c0: 
        next_state = c1;
      c1:
        next_state = c2;
      c2:
        next_state = c3;
      c3:
        next_state = c4;
      c4:
        next_state = c5;
      c5:
        next_state = c6;
      c6:
        next_state = c7;
      c7:
        next_state = c0;
      default:
        next_state = c0;
    endcase
    end
  
endmodule

//--------------------------- TestBench ---------------------------//
module counter3Bit_tb;

  logic clock, rst_p;
  logic [2:0] counter;

  counter3Bit dut(.*);

  always #2 clock = ~clock;

  initial begin
    $dumpfile("counter3Bit.vcd");
    $dumpvars(0, counter3Bit_tb);

    clock = 0;
    rst_p = 1;          

    #10;

    rst_p = 0;         

    #80;

    $finish;
  end

  initial begin
    $monitor("time=%0t rst=%b counter=%b", $time, rst_p, counter);
  end

endmodule
