//--------------------------- Design ---------------------------//
module fullAdder(input logic a, b, cin,
                 output logic s, cout);
  
  assign s = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
  
endmodule 



//--------------------------- Testbench ---------------------------//
module fullAdder_tb;
  
  logic a, b, cin;
  logic s, cout;
  
  fullAdder dut(.*);
  
  initial begin
    for(int i = 0; i<8; i++) begin
      {a, b, cin} = i;
      #1;
      $display ("a = %b b = %b cin = %b | sum = %b cout = %b", a, b, cin, s, cout);
      #10;
    end
  end
endmodule
