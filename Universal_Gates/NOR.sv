//--------------------------- Design ---------------------------//
module uniNor(input logic a, b,
              output wire N_nota, N_notb, N_Or, N_And);
  
  wire w1, w2, w3;
  
  assign N_nota = ~(|a);
  assign N_notb = ~(|b);
  
  assign w1 = ~(a | b);
  assign N_Or = ~(| w1);
  
  assign w2 = ~(| a);
  assign w3 = ~(| b);
  assign N_And = ~(w1 | w3);
  
endmodule 

//--------------------------- TestBench ---------------------------//
module uniNor_tb;
  
  logic a, b;
  wire N_nota, N_notb, N_Or, N_And;
  
  uniNor dut(.*);
  
  initial begin 
    $dumpfile("dumps.vcd");
    $dumpvars(1);
    
    repeat (100) begin
      a = $urandom; 
      b = $urandom;
      
      #1; 
      $display("a=%b b=%b | N_nota=%b, N_notb=%b, N_Or=%b, N_And=%b", a, b, N_nota, N_notb, N_Or, N_And);
      
      #2;
    end 
    $finish;
    
  end
endmodule 
