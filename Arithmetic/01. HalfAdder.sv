//Arithmetic
//Combinational - Not sequential because it doesnt have memory element
//Application - Arithmetic Units
//1. Basic building block for: Full Adders, Ripple Carry Adders, Carry Lookahead Adders
//2. ALUs (Arithmetic Logic Units)
//Inside CPUs, GPUs, DSPs (as part of larger adders)
//3. Multipliers Partial product addition stages
//4. Address Generation Increment logic (small add operations)

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
