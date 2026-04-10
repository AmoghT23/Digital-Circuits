//--------------------------- Design ---------------------------//

module JKFlipFlop(input logic clk, rstn,
                  input logic j, k,
                  output logic q, q_bar);
  
  always @(posedge clk) begin
    if(!rstn) q<= 0;
    else begin
      case({j, k})
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= ~q;
      endcase
    end
  end
  assign q_bar = ~q;
endmodule 

//--------------------------- TestBench ---------------------------//

module JKFlipFlop_tb;
  
  reg clk, rstn;
  reg j, k;
  wire q, q_bar;
  
  JKFlipFlop dut(clk, rstn, j, k, q, q_bar);
  
  always #2 clk = ~clk;
  
  initial begin
    clk = 0; rstn = 0;
    $display("Reset = %0b --> q = %b q_bar = %b", rstn, q, q_bar);
    #3 rstn = 1;
    $display("Reset = %0b --> q = %b q_bar = %b", rstn, q, q_bar);
    
    drive(2'b00);
    drive(2'b01);
    drive(2'b10);
    drive(2'b11);
    #5;
    $finish;
  end
  
  task drive(bit [1:0] ip);
    @(posedge clk);
    {j, k} = ip;
    #1; 
    $display("j=%b, k=%b --> q=%b q_bar=%b", j, k, q, q_bar);
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule 
