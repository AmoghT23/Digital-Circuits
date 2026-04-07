//--------------------------- Design ---------------------------//

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
  

module arrayMultiplier(input logic [3:0]a, b,
                       output logic [7:0]z);
  
  wire p[3:0][3:0];
  wire [10:0]c;
  wire[5:0]s;
  
  genvar i;
  generate 
  for (i=0; i<4; i++) begin
    and a0(p[i][0], a[i], b[0]);
    and a1(p[i][1], a[i], b[1]);
    and a2(p[i][2], a[i], b[2]);
    and a3(p[i][3], a[i], b[3]);
  end
  endgenerate
  
  assign z[0] = p[0][0];
           
  halfAdd h0(p[0][1], p[1][0], z[1], c[0]);
  halfAdd h1(p[1][1], p[2][0], s[0], c[1]);
  halfAdd h2(p[2][1], p[3][0], s[1], c[2]);
           
           fullAdd f0(p[0][2], c[0], s[0], z[2], c[3]);
           fullAdd f1(p[1][2], c[1], s[1], s[2], c[4]);
           fullAdd f2(p[2][2], c[2], p[3][1], s[3], c[5]);
           
           fullAdd f3(p[0][3], c[3], s[2], z[3], c[6]);
           fullAdd f4(p[1][3], c[4], s[3], s[4], c[7]);
           fullAdd f5(p[2][3], c[5], p[3][2], s[5], c[8]);
			           
           halfAdd h3(c[6], s[4], z[4], c[9]);
           fullAdd f6(c[9], c[7], s[5], z[5], c[10]);
           fullAdd f7(c[10], c[8], p[3][3], z[6], z[7]);
endmodule 

//--------------------------- TestBench ---------------------------//

class rand_gen;
  randc bit [3:0] ra, rb;
endclass

module arrayMultiplier_tb;
  
  reg [3:0]a, b;
  wire [7:0]z;
  
  arrayMultiplier dut(a, b, z);
  
   rand_gen rnd;
  
  initial begin
    rnd = new();
    
    repeat(10) begin
      assert(rnd.randomize());
      a = rnd.ra;
      b = rnd.rb;
      
      #1;
      
      $monitor("a = %b a = %d b = %b b = %d -> z = %b z = %d", a, a, b, b, z, z);
    end 
    
    $finish;
    
  end
endmodule 
      
    
    
    
    
    
    
