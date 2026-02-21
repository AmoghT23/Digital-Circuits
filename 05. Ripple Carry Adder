//--------------------------- Design ---------------------------//

module fullAdder (
  input  logic a, b, cin,
  output logic sum, cout
);
  assign {cout, sum} = a + b + cin;
endmodule


module rippleAdder #(parameter SIZE = 4) (
  input  logic [SIZE-1:0] A, B,
  input  logic            Cin,
  output logic [SIZE-1:0] S,
  output logic            Cout
);

  logic [SIZE:0] carry;
  assign carry[0] = Cin;
  assign Cout     = carry[SIZE];

  genvar g;
  generate
    for (g = 0; g < SIZE; g++) begin : FA_GEN
      fullAdder fa (
        .a   (A[g]),
        .b   (B[g]),
        .cin (carry[g]),
        .sum (S[g]),
        .cout(carry[g+1])
      );
    end
  endgenerate

endmodule


//--------------------------- TestBench ---------------------------//
module rippleAdder_tb;
  
  parameter SIZE = 4;
  
  logic [SIZE-1 : 0] A, B;
  logic Cin;
  logic [SIZE : 0] add;
  logic [SIZE-1 : 0] S;
  logic Cout;
  
  
  rippleAdder #(SIZE) dut(.*);
  assign add = {Cout, S};
  
  class stim;
    rand logic [SIZE-1 : 0] A, B;
    rand logic Cin;
    
    constraint valid_range{
      A inside{[0:(1<<SIZE)-1]};
      B inside{[0:(1<<SIZE)-1]};
    }
    
    constraint carry_balance{
      A + B + Cin >= (1<<SIZE)/2;
    }
   endclass
  
  stim s;
  
  initial begin
    s = new();
    
    repeat (30) begin
      assert (s.randomize())
      else 
        $fatal("Randomization Failed");
      
     
      A = s.A;
      B = s.B;
      Cin = s.Cin;
      
      #1;
      
      $display("A = %b B = %b Cin =%b | S = %b Cout = %b Addition = %0d", A, B, Cin, S, Cout, add);
               end
               end 
               endmodule 
