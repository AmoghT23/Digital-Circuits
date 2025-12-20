//--------------------------- Design ---------------------------//

module adder(input logic a, b,
             output logic s, c);
  
  assign s = a ^ b;
  assign c = a & b;
  
endmodule 

//--------------------------- TestBench ---------------------------//

module adder_tb;
  
  logic A, B;
  logic S, C;
  
  adder dut(.a(A), .b(B), .s(S), .c(C));
  
  initial begin
    for(int i=0; i<4; i++) begin
    {A,B} = i;
      #1;
    $display("The value of A = %b , B = %b , Sum = %b , Carry = %b", A, B, S, C);   
    #10;
    end
  end
endmodule
