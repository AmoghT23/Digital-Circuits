//--------------------------- Design ---------------------------//

parameter WIDTH = 2;

module halfAdd(
  				input logic a, b,
  				output logic s, c);
  
  assign s = a ^ b;
  assign c = a & b;
  
endmodule 

module vedicMul(
  				input logic [WIDTH-1:0] a, b, 
  output logic [WIDTH:0]p);
  
  logic x1, x2;
  logic sum, carry;
  
  assign p[0] = a[0] & b[0];
  
  assign x1 = a[1] & b[0];
  assign x2 = a[0] & b[1];
  
  halfAdd add1(.a(x1), .b(x2), .s(sum), .c(carry));
  
  assign p[1] = sum;
  assign p[2] = (a[1] & b[1]) ^ carry;
  
endmodule 

//--------------------------- TestBench ---------------------------//

module vedicMul_tb;
  
  parameter WIDTH = 2;
  
  reg [WIDTH-1:0] a, b;
  wire [WIDTH:0] p;
  
  int expected;
  
  vedicMul dut(.a(a), .b(b), .p(p));
  
  initial begin
    a = 2'd2;
    b = 2'd3;
    
    #5;
    
    expected = a * b;
    
    $display("a = %b (%0d), b = %b (%0d) -> p = %b (%0d), expected = %0d",
                  a, a, b, b, p, p, expected);
    
        if (p == expected)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        $finish;
    
  end
endmodule 
      
    
    
    
    
    
    
