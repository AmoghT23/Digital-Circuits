//--------------------------- Design ---------------------------//

module halfSubtract(input logic a, b,
                    output logic sub, bor);
  
  assign sub = a ^ b;
  assign bor = (~a) & b;
  
endmodule 

//--------------------------- Testbench ---------------------------//

module halfSubtract_tb;
  
  logic a, b;
  logic sub, bor;
  
  halfSubtract dut(.*);
  
  initial begin
    
    for(int i = 0; i<=3 ; i++) begin
      {a, b} = i;
      #1;
      $display("a = %b b = %b | sub = %b bor = %b", a, b, sub, bor);
      #10;
      end
   end
endmodule
