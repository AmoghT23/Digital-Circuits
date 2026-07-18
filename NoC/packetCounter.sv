/*Design To count the number of packets*/
module packetCounter(
  input logic clk,
  input logic reset,
  input logic packet,
  output logic [7:0] count
);

  typedef enum logic {IDLE=1'b0, COUNTING=1'b1} state_t;
  state_t state, next_state;

  always_ff @(posedge clk) begin
    if(reset)
      state <= IDLE;
    else
      state <= next_state;
  end
  
  always_comb begin
    next_state = IDLE;
    case(state)
      IDLE:
        next_state = packet ? COUNTING : IDLE;
      COUNTING:
        next_state = packet ? COUNTING : IDLE;
    endcase
  end

  always_ff @(posedge clk) begin
    if(reset)
      count <= 0;
    else if(state == COUNTING)
      count <= count + 1;
  end
endmodule


/*Testbench*/
module tb;

  logic clk;
  logic reset;
  logic packet;
  logic [7:0] count;

  packetCounter DUT(.*);

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    packet = 0;
    #12;
    reset = 0;

    repeat(10) begin
      @(negedge clk);
      packet = 1;
    end
    @(negedge clk);
    packet = 0;
    #20;
    $display("Packet count = %0d", count);

    $finish;
  end
endmodule
