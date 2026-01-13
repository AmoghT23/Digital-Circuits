//--------------------------- Design ---------------------------//

module SRFlipflop(input logic clk, rstn,
                  input logic s, r,
                  output logic q,
                  output logic q_bar);
  
  always @(posedge clk) begin
    if(!rstn) 
      q<=0;
    else begin
      case({s, r}) 
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
      endcase
    end
    end
    assign q_bar = ~q;
    endmodule

//--------------------------- TestBench ---------------------------//

module SRFlipFlop_tb;
  reg clk, rstn;
  reg s, r;
  wire q, q_bar;
  
  SRFlipflop dut(clk, rstn, s, r, q, q_bar);
  
  always #2 clk = ~clk;
  
  initial begin 
    clk = 0;
    rstn = 0;
    $display("Reset=%b --> q = %b q_bar = %b", rstn, q, q_bar);
    
    #3; 
    rstn = 1;
    $display("Reset=%b --> q = %b q_bar = %b", rstn, q, q_bar);
    
    drive(2'b00);
    drive(2'b01);
    drive(2'b10);
    drive(2'b11);
    #5;
    $finish;
  end
  
  task drive(bit[1:0] ip);
    @(posedge clk); 
    {s,r} = ip;
    #1;
    $display("s = %b r = %b --> q = %b q = q_bar", s, r, q, q_bar);
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
