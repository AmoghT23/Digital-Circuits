//--------------------------- Design ---------------------------//

module dFlipFlop (
  					input logic clk, rstn,
  					input logic d,
  output logic q);
  
  always @(posedge clk or negedge rstn) begin 
    if(!rstn) 
      	q <= 0;
    else 
      	q <= d;
  end
endmodule 
    
  
//--------------------------- TestBench ---------------------------//

module dFlipFlop_tb;

  reg clk, rstn;
  reg d;
  wire q;

  dFlipFlop dut(clk, rstn, d, q);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rstn = 0;
    d = 0;

    #7 rstn = 1;

    repeat (5) begin
      d = $urandom_range(0,1);
      #10;
    end

    rstn = 0;
    #6 rstn = 1;

    repeat (5) begin
      d = $urandom_range(0,1);
      #10;
    end

    $finish;
  end

  always @(posedge clk or negedge rstn) begin
    $display("TIME=%0t | rstn=%b | d=%b | q=%b",
              $time, rstn, d, q);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, dFlipFlop_tb);
  end

endmodule

    
