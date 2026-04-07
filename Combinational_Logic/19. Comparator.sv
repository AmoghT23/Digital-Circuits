//--------------------------- Design ---------------------------//

module comparator(
  input logic [3:0] A, B,
  output logic aGreatb, aLessb, aEqualb);
  
  always @(*) begin
    aGreatb = 0; aLessb = 0; aEqualb = 0;
    
    if(A>B) aGreatb = 1'b1;
    else if(A<B) aLessb = 1'b1;
    else aEqualb = 1'b1;
  end
endmodule 
    
//--------------------------- TestBench ---------------------------//

 module comparator_tb;
  
  logic [3:0] A,B;
  wire aGreatb, aLessb, aEqualb;
  
  comparator dut(A, B, aGreatb, aLessb, aEqualb);
  
  initial begin
    $monitor("A = %0h, B = %0h -> aGreatb = %b, aLessb = %b, aEqualb = %b", A, B, aGreatb, aLessb, aEqualb);
    
    repeat(9) begin
      A = $random;
      B = $random;
      #1;
    end
  end
endmodule 
