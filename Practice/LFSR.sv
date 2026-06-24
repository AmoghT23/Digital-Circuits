//Design 
module LFSR(
  input logic clk, rst, 
  input logic mode,
  output logic [7:0] q);
  
  logic [7:0] q_next;
  logic [7:0] q_f, q_g;
  
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) 
      q <= 8'b00000001;
    else
      q <= q_next;
  end
  
  always_comb begin
    logic feedback;
  	feedback = (q[7] ^ q[0]) ^ (q[5] ^ q[6]);
    
    q_f = {q[6:0], feedback};
  end
  
  always_comb begin
      logic fb;
    logic [7:0] shifted;
    
      shifted = q >> 1;
      
    fb = q[7];
    if(fb == 1)
      shifted ^= {q[0], q[5], q[6], q[7]};

  end
  
  assign q_next = (mode) ? q_f: q_g;
endmodule 

//Testbench
module LFSR_tb;
  
  logic clk, rstn;
  logic mode;
  logic [7:0] q;
  
  LFSR dut (.*);
  
  always #5 clk = ~clk;
  
  initial begin
    clk=0;
    rstn=0;
    
    #12;
    rstn=1;
    #5;
    mode = 0;
    repeat(20) begin
      @ (posedge clk); 
      
      $display("[%0t] q=%08b", $time, q);
      
      assert property (
        @(posedge clk) 
        disable iff(!rstn)
        q != 8'b00000000
      );
    end
        
        #10;
        mode = 1;
        repeat(20) begin
      @ (posedge clk); 
      
      $display("[%0t] q=%08b", $time, q);
      
      assert property (
        @(posedge clk) 
        disable iff(!rstn)
        q != 8'b00000000
      );
    end
        
    $finish;
  end
endmodule 
        
        
        
        
