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
      
      
