//Design 
module LFSR(
  input logic clk, rstn, 
  output logic [7:0] q);
  
  logic feedback;
  assign feedback = q[7] ^ q[0];
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) 
      q <= 8'b00000001;
    else
      q <= {q[6:0], feedback};
  end
endmodule 

//Testbench
module LFSR_tb;
  
  logic clk, rstn;
  logic [7:0] q;
  
  LFSR dut (.*);
  
  always #5 clk = ~clk;
  
  initial begin
    clk=0;
    rstn=0;
    
    #12;
    rstn=1;
    
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
