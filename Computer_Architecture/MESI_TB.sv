//Testbench
module test_mesi;
  logic clk, reset;
  logic proc_read, proc_write, snoop_read, snoop_invalidate, shared_hit;
  logic read_from_L2, write_to_L2, return_data_to_L2;
  mesi_state_t state_out;
  
  mesi dut(.clk, .reset,
           .proc_read, .proc_write, .snoop_read, .snoop_invalidate,
           .shared_hit,
           .read_from_L2, .write_to_L2, .return_data_to_L2,
           .state_out);
  
  always #5 clk = ~clk;
  
  initial begin
    $display("================= MESI Protocol Testing =================");
    clk = 0;
    reset = 1;
    proc_read = 0; proc_write = 0;
    snoop_read = 0; snoop_invalidate = 0; shared_hit = 0;
    #10 reset = 0;
    
    //Read Miss
    
    proc_read = 1; #10;
    proc_read = 0; #10;
    
    //Write Hit in E -> M
    
    proc_write = 1; #10;
    proc_write = 0; #10;
    
    //Snoop Read -> return Data, M->S
    
    snoop_read = 1; #10;
    snoop_read = 0; #10;
    
    //Snoop Invalidation
    
    snoop_invalidate = 1; #10;
    snoop_invalidate = 0; #10;
    
    $display("Test Complete");
    $finish;
  end
  
  //Simple Monitor
  
  always @ (posedge clk) begin
    $display("Time=%0t  |  State=%s  |  R_L2=%b  |  W_L2=%b  |  Ret=%b", $time, state_out.name(), read_from_L2, write_to_L2, return_data_to_L2);
  end 
endmodule 
