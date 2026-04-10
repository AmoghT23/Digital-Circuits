//--------------------------- Design ---------------------------//
module bcd7Seg(input logic w, x, y, z, 
               output logic a, b, c, d, e, f, g);
  
  assign a = ~x& ~z | y | x&z | w;
  assign b = ~x | ~y& ~z | y&z;
  assign c = ~y | z | x;
  assign d = ~x& ~z | ~x&y | x& ~y&z | y& ~z | w;
  assign e = ~x& ~z | y& ~z;
  assign f = ~y& ~z | x& ~y | x& ~z | w;
  assign g = ~x& y | x& ~y | w | x& ~z;
  
endmodule 

//--------------------------- TestBench ---------------------------//

module bcd7Seg_tb;
  
  logic w, x, y, z;
  reg a, b, c, d, e, f, g;
  
  bcd7Seg dut(.*);
  
  initial begin
    $dumpfile("dumps.vcd");
    $dumpvars(1);
    
    for(int i=0; i<16; i++) begin
      {w, x, y, z} = i;
      #1;
      
      $display("w=%b x=%b y=%b z=%b | a=%b b=%b c=%b d=%b e=%b f=%b g=%b", w, x, y, z, a, b, c, d, e, f, g);
      
      #1;
    end
    $finish;
  end
endmodule 
    
