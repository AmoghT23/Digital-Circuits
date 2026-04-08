/*Arithmetic Circuit
Combinational Circuit
Full-adders are heavily used in real hardware, unlike half-adders:

1. Multi-bit Adders
Ripple Carry Adders (RCA)
Carry Lookahead Adders (CLA)
Carry Select Adders
2. ALUs (Arithmetic Logic Units)
Core arithmetic blocks in CPUs, GPUs, DSPs
3. Multipliers
Wallace tree / Dadda tree reduction stages
4. Accumulators & Counters
Increment/decrement operations
5. Address Arithmetic
Memory addressing and pointer updates

RTL
Where it is used:
Custom datapath design
Arithmetic-heavy blocks (DSP, crypto, signal processing)
Low-level optimization (timing/power critical paths)

Verification
Full-adders are widely used in verification environments:

1. DUT for Learning / Training
Common in:
UVM tutorials
Interview problems
Basic verification flows
2. Assertions (Functional Checking)
assert property (@(posedge clk)
    Sum == (A ^ B ^ Cin)
);
assert property (@(posedge clk)
    Cout == ((A & B) | (B & Cin) | (A & Cin))
);
3. Functional Coverage
covergroup cg;
    coverpoint {A, B, Cin};
endgroup
4. Golden Reference Model
Used in scoreboards for checking arithmetic correctness
5. Corner Case Verification
Carry propagation scenarios:
All 1’s input
Long carry chains in multi-bit adders

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
