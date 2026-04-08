/*Arithmetic Circuit
Combinational Circuit - Not sequential because it doesnt have memory element

Application - Arithmetic Units
1. Basic building block for: Full Adders, Ripple Carry Adders, Carry Lookahead Adders
2. ALUs (Arithmetic Logic Units)
Inside CPUs, GPUs, DSPs (as part of larger adders)
3. Multipliers Partial product addition stages
4. Address Generation Increment logic (small add operations)

RTL Applications 
Where it is used:
Educational designs
Small custom datapaths
Bit-level arithmetic optimizations
Low-power or highly optimized custom logic
1. Basic DUT (Device Under Test)
Used in:
Testbench learning
UVM tutorials
Sanity checking environments
2. Assertion Writing Practice
assert property (@(posedge clk) Sum == (A ^ B));
3. Functional Coverage
covergroup cg;
    coverpoint {A, B};
endgroup
4. Golden Reference Models
Used as simple reference logic in scoreboards*/

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
