//Design 
module dFF2(input logic clk, rstn,
           input logic d, 
           output logic q, q1);
  
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
    q <= 0; 
    q1 <= 0;
      end else begin 
    q1 <= d; 
    q <= q1;
      end
  end 
endmodule

//Testbench
module dFF2_tb;
  
  logic d;
  logic clk, rstn;
  logic q, q1;
  
  dFF2 dut(.*);
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dFF2.vcd");
    $dumpvars(1);
    
    clk = 0;
    rstn = 0;
    d = 0;
    
    #5;
    
    rstn = 1;
    repeat (10) begin
      d = $random;
    #10;
      $display("rstn = %0b, d=%0b | q1=%0b q=%0b", rstn, d, q1, q);
    end
    $finish;
  end 
endmodule 
    
