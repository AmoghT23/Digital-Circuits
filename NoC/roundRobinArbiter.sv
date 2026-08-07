// *** Design ***
// Code your design here
module roundRobinArbiter #(parameter N = 4)
  (input logic clk, rst_n, 
   input logic [(N-1):0] req,
   output logic [(N-1):0] grant,
   output logic valid_grant);
  
  logic [$clog2(N)-1:0] pointer;
  logic [$clog2(N)-1:0] winner_index, candidate;
  logic winner_found;
  
  always_ff @(posedge clk) begin
    if(!rst_n) 
      pointer <= 0;
    else if (valid_grant) begin
      if(winner_index == N-1)
        pointer <= 0;
      else
      	pointer <= winner_index + 1;
    end
  end 
  
  always_comb begin 
    grant = '0;
    valid_grant = '0;
    winner_found = '0;
    winner_index = '0;
    
    
    candidate = pointer;
    
    
    for (integer n=0; n<N; n++) begin
      
      if(req[candidate] && ~winner_found) begin
        grant[candidate] = 1;
      	winner_index = candidate;
      
      	valid_grant = 1;
      	winner_found = 1;
      end
      
      if(candidate == N-1)
        	candidate = 0;
      else 
        candidate = candidate + 1;
    end
  end
      
//*** Testbench

  class roundRobinArbiterC;
parameter N = 4;

rand logic [(N-1):0] req;
rand int unsigned requester_id;
logic [(N-1):0] prev_req;

typedef enum logic [1:0] {BURST, CHANGING, RANDOM} traffic_mode_t;
rand traffic_mode_t mode;

constraint c1 {
    req != '0;
}

constraint c2 {
    $countones(req) dist {1:=60, 2:=30, 4:=10};
}

constraint c3 {
    requester_id inside {[0:N-1]};
    requester_id dist {0:=1, 1:=1, 2:=1, 3:=1};
}

constraint c3_connect {
    if ($countones(req) == 1)
        foreach(req[i])
            if (i == requester_id)
                req[i] == 1;
            else
                req[i] == 0;
}

constraint c4_mode {
    mode dist {BURST:=35, CHANGING:=25, RANDOM:=40};
}

constraint c4_behavior {
    if (mode == BURST)
        req == prev_req;
    else if (mode == CHANGING)
        req != prev_req;
}

endclass


module roundRobinArbiter_tb;

parameter N = 4;

logic clk;
logic rst_n;
logic [(N-1):0] req;
logic [(N-1):0] grant;
logic valid_grant;

roundRobinArbiter dut(.*);

roundRobinArbiterC rrA;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rrA = new();

    clk = 0;
    rst_n = 0;

    #10;
    @(posedge clk);
    rst_n = 1;

    rrA.prev_req = '0;

    repeat(20) begin
        @(posedge clk);

        if(rrA.randomize()) begin
            req = rrA.req;

            $display("REQ=%b MODE=%s GRANT=%b VALID=%b",
                     req,
                     rrA.mode.name(),
                     grant,
                     valid_grant);

            rrA.prev_req = rrA.req;
        end
        else begin
            $display("Randomization failed");
        end
    end

    $finish;
end

endmodule
