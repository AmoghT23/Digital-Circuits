//--------------------------- Design ---------------------------//
module uniNand (input logic a, b,
                output reg na_and1, na_or2, na_nota, na_notb);
  
  wire w1, w2, w3;
  
  assign na_nota = ~(& a);
  assign na_notb = ~& b;
  assign w3 = ~(a & b);
  assign na_and1 = ~(& w3);
  assign w1 = ~& a;
  assign w2 = ~& b;
  assign na_or2 = ~(w1 & w2);
  
endmodule 


//--------------------------- TestBench ---------------------------//
module uniNand_tb;
  
  logic a, b;
  wire na_and1, na_or2, na_nota, na_notb;
  
  uniNand dut (.*);
  
  initial begin
    $dumpfile("dumps.vcd");
    $dumpvars(1);
    
    for(int i=0; i<4; i++) begin
      {a, b} = i;
      
      #1;
      
      $display("a=%b b=%b | na_and1=%b na_or2=%b na_nota=%b na_notb=%b", a, b, na_and1, na_or2, na_nota, na_notb);
      
      #5;
    end
      $finish;
  end
endmodule 
