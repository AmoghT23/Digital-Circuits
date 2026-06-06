//Design 
module LFSR(
  input logic clk, rstn, 
  output logic [3:0] q);
  
  logic feedback;
  assign feedback = q[3] ^ q[0];
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) 
      q <= 4'b0001;
    else
      q <= {q[2:0], feedback};
  end
endmodule 

//Testbench
module LFSR_tb;
  
  logic clk, rstn;
  logic [3:0] q;
  
  LFSR dut (.*);
  
  always #5 clk = ~clk;
  
  initial begin
    clk=0;
    rstn=0;
    
    #12;
    rstn=1;
    
    repeat(20) begin
      @ (posedge clk); 
      
      $display("[%0t] q=%b", $time, q);
      
      assert property (
        @(posedge clk) 
        disable iff(!rstn)
        q != 4'b0000;
      $display("[%0t] q=%b", $time, q);
      );
    end
    $finish;
  end
endmodule 
