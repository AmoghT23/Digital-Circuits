// ------------design ------------
module SRAM #(parameter DEPTH = 64,
              parameter WIDTH = 16)
  (input logic clk, rst_n,
   input logic ce_n, we_n,
   input logic [$clog2(DEPTH)-1:0] addr,
   input logic [WIDTH-1:0] w_data,
   output logic [WIDTH-1:0] r_data);
 
  logic [WIDTH-1:0] mem [0:DEPTH-1];
 
 
  always @(posedge clk) begin
    if(!rst_n) begin
      r_data <= 0;
    end else if (!ce_n) begin
      if(!we_n) begin
        mem[addr] <= w_data;
      end else begin
        r_data <= mem[addr];
      end end else begin
        r_data <= 'z;
      end
  end
endmodule 

//Testbench

// Code your testbench here
// or browse Examples
module SRAM_tb; 
  
  parameter DEPTH = 64;
  parameter WIDTH = 16;
  
  logic clk, rst_n;
  logic ce_n, we_n;
  logic [$clog2(DEPTH)-1:0] addr;
  logic [WIDTH-1:0] w_data;
  logic [WIDTH-1:0] r_data;
  logic [WIDTH-1:0] expected_data;
 
  SRAM #(DEPTH, WIDTH) sram1(.*);
 
  initial clk = 0;
  always #5 clk = ~clk;
 
  initial begin
    rst_n = 0;
    ce_n = 1; 
    we_n = 1;
    addr = 0; 
    w_data = 0;
   
    #10;
    rst_n = 1;
    #5;
    
    for(int i=0; i<10; i++) begin
    expected_data = $urandom; 
    
    $display("[%0t] Starting the Test Cases", $time);
    
    $display("[%0t] Test Case1: Basic Read and Write", $time);
    @(posedge clk);
    //Turn on the write mode  
      ce_n = 0;
      we_n = 0;
      addr = 6'd10;
      w_data = expected_data;
    $display ("Expected Data = %0h", expected_data);
      
	//Turn off the write mode
    @(posedge clk);
    we_n = 1;
    addr = 6'd10;
    
    @(posedge clk);
    #1;
    
    if(r_data == expected_data) begin
      $display("[%0t] [PASS] Test:%0d Read back successful from the address 10", $time, i);
    end else begin
      $display("[%0t] [FAIL] Test:%0d Read back unsuccessful from address 10: 0x%h",$time, i, r_data);
    end
    end
    
    $display("[%0t] Test Case2: Max Boundary Access", $time);
    @ (posedge clk);
    we_n = 0;
    addr = 6'd63;
    w_data = 16'h5555;
    
    @(posedge clk);
    we_n = 1;
    addr = 6'd63;
    
    @(posedge clk);
    #1;
    if(r_data == 16'h5555) begin
      $display("[%0t] [PASS] Max Boundary Address 63 passed", $time);
    end else begin
      $display("[%0t] [FAIL] Max Boundary Address failed: 0x0h", $time, r_data);
    end
    
    @(posedge clk);
    ce_n = 1;
       
    #10;
    $display("[%0t] Testing Done", $time);
    $finish;
  end
endmodule
