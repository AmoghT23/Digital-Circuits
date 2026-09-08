//Design 
module basicGates(input logic a, b, 
                  output logic yAnd, yOr, yNotA,
                  yNotB, yNand, yNor, yXor, yXnor);
  
  assign yAnd = b ? a : 0;
  
  assign yOr = b ? 1 : a;
  
  assign yNotA = a ? 0 : 1;
  
  assign yNotB = b ? 0 : 1;
  
  assign yNand = b ? 0:(~a);
  
  assign yNor = b ? 0:(~a);
  
  assign yXor = b ? (~a): a; 
  
  assign yXnor = b ? a: (~a);
  
endmodule 
  
//Testbench (Hardcoded, but can use a function instead)
module tb;
  logic a, b;
  logic yAnd, yOr, yNotA,
  		yNotB, yNand, yNor, 
  		yXor, yXnor;
  
  basicGates dut(.*);
  
  
  initial begin
    for(int i=0; i<4; i++) begin
      {a, b} = i;
      #5;
      
      $display("a=%0b, b=%0b | yXnor = %0d", a, b, yXnor);
    end
  end
endmodule 
