//Design 

module JohnsonCount #(parameter N=16)
  (input logic clk, rst_n,
   input logic mode, en, 
   output logic [N-1:0] count_out,
   output logic valid);
	
  wire feedback_bit;
  assign feedback_bit = mode ? (~count_out[N-1]) : (count_out[N-1]);
  
  always_ff @(posedge clk) begin
    if(!rst_n)
      count_out <= mode ? '0 : 1'b1;
    else if (en)
      count_out <= {count_out[N-2:0], feedback_bit};
  end
endmodule 

//Testbench (Not yet complete)

module JohnsonCount_tb #(parameter N = 16);
  
  
  logic clk, rst_n; 
  logic mode, en;
  logic [N-1:0] count_out;
  logic valid;
  
  JohnsonCount #(.N(N)) jC1 (.*);
  
  always #5 clk = ~clk;
  
  initial begin
    $display ("[%0t] Staring the Testbench for the Johnson Counter", $time);
    
    $dumpfile("JohnsonCount.vcd");
    $dumpvars(1);
    
    assign clk = 0;
    assign rst_n = 0;
    assign en = 0;
    assign mode = 0;
    $display ("[%0t] clk = %0b, rst_n = %0b, en = %0b, mode = %0b | count_out = %0b", $time, clk, rst_n, en, mode, count_out); 
    
    if(mode) 
      $display("Johnson Counter");
    else
      $display("Ring Counter");
    
    #5;
    
    assert property (@(posedge clk) rst_n);
      #5;
    $display ("[%0t] rst_n = %0b, en = %0b, mode = %0b | count_out = %0b", $time, rst_n, en, mode, count_out); 
    
    #5;
    
    
    assign en = 1;
    assign mode = 1;
    $display ("[%0t] rst_n = %0b, en = %0b, mode = %0b | count_out = %0b", $time, rst_n, en, mode, count_out); 
    
    if(mode) 
      $display("Johnson Counter");
    else
      $display("Ring Counter"); 
  end
  
endmodule 
    
