//--------------------------- Design ---------------------------//

parameter WIDTH = 4; 
module halfAdd(input logic a, b,
               output logic s, c);
  
  assign s = a ^ b;
  assign c = a & b;
  
endmodule 

module fullAdd(input logic a, b, cin,
               output logic s, c);
  
  assign s = a ^ b ^ cin;
  assign c = (a & b) | (b & cin) | (cin & a);
  
endmodule 

module wallMultiply(input logic [WIDTH-1:0]a, b,
                    output logic [7:0]p);
  wire [15:0]w;
  wire s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12;
  wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12;
  
      genvar i, j;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin
            for (j = 0; j < WIDTH; j = j + 1) begin
                assign w[i*WIDTH + j] = a[i] & b[j];
            end
        end
    endgenerate
  
  halfAdd HA1 (.a(w[9]),  .b(w[12]),  .s(s1), .c(c1));
  halfAdd HA2 (.a(w[10]), .b(w[13]),  .s(s2), .c(c2));
  halfAdd HA3 (.a(w[5]),  .b(w[8]),   .s(s3), .c(c3));
  fullAdd FA4 (.a(s1),    .b(w[3]),   .cin(w[6]), .s(s4), .c(c4));
  fullAdd FA5 (.a(c1),    .b(s2),     .cin(w[7]), .s(s5), .c(c5));
  fullAdd FA6 (.a(c2),    .b(w[11]),  .cin(w[14]), .s(s6), .c(c6));
  halfAdd HA7 (.a(w[1]),  .b(w[4]),   .s(s7), .c(c7));
  fullAdd FA8 (.a(s3),    .b(w[2]),   .cin(c7), .s(s8), .c(c8));
  fullAdd FA9 (.a(c3),    .b(s4),     .cin(c8), .s(s9), .c(c9));
  fullAdd FA10(.a(c4),    .b(s5),     .cin(c9), .s(s10), .c(c10));
  fullAdd FA11(.a(c5),    .b(s6),     .cin(c10), .s(s11), .c(c11));
  fullAdd FA12(.a(c6),    .b(w[15]),  .cin(c11), .s(s12), .c(c12));
  
  assign p[0] = w[0];
  assign p[1] = s7;
  assign p[2] = s8;
  assign p[3] = s9;
  assign p[4] = s10;
  assign p[5] = s11;
  assign p[6] = s12;
  assign p[7] = c12;
  
  
endmodule 
  
//--------------------------- TestBench ---------------------------//

module wallMultiply_tb;
  
  parameter WIDTH = 4;
  
  reg [WIDTH-1:0]a, b;
  wire [7:0]p;
  
  wallMultiply dut(.a(a), .b(b), .p(p));
  
  integer expected;
  
  initial begin
    
    a = 4'd5;
    b = 4'd10;
    
    #1;
    
    expected = a * b;
    
    if(p == expected) begin
      $display("All cases passed A = %0d B = %0d -> p = %0d expected = %0d", a, b, p, expected);
    end 
    else begin
      $display("Cases failed A = %0d B = %0d -> p = %0d expected = %0d", a, b, p, expected);
    end
    $finish;
    
  end
endmodule 
  
  
    
