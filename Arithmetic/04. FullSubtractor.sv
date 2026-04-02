//--------------------------- Design ---------------------------//

module fullSubtract(input logic a, b, bin,
                 output logic sub, bor);
  
  
  assign sub = a ^ b ^ bin;
  assign bor = ((~a) & b) | (~(a ^ b) & bin);
  
endmodule 


//--------------------------- Testbench ---------------------------//

module halfSubtract_tb;
  
  logic a, b, bin;
  logic sub, bor;
  
  fullSubtract dut(.*);
  
  initial begin
    for(int i = 0; i < 8 ; i++) begin
      {a, b, bin} = i;
      #1;
      $display("a = %b b = %b bin = %b | sub = %b bor = %b", a, b, bin, sub, bor);
      #10;
    end
  end
endmodule 
