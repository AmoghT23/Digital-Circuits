//--------------------------- Design ---------------------------//
module bcd_exc3(input reg [3:0]b , 
                output reg [3:0] e);
  
  assign e[0] = ~b[0];
  assign e[1] = ~(b[1]&b[0]) | (b[1]&b[0]);
  assign e[2] = (~b[2]&b[0]) | (~b[2]&b[1]) | (b[2]&~b[1]&~b[0]);
  assign e[3] = b[3] | b[0]&b[2] | b[1]&b[2];
  
endmodule 

//--------------------------- TestBench ---------------------------//
module bcd_exc3_tb;
  
  logic [3:0] b;
  reg [3:0] e;
  
  bcd_exc3 dut(.*);
  
  initial begin
    $dumpfile("dumps.vcd");
    $dumpvars(1);
    
    for(int i=0; i<16; i++) begin
      {b} = i;
      #1;
      
      $display("b[3]=%b b[2]=%b b[1]=%b b[0]=%b | e[3]=%b e[2]=%b e[1]=%b e[0]=%b", b[3], b[2], b[1], b[0], e[3], e[2], e[1], e[0]);
      
      #2;
    end
    $finish;
    end
endmodule
    
