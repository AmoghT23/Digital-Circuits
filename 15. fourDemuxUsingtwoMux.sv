//--------------------------- Design ---------------------------//

module twoDeMux(input logic i,
              input logic sel,
              output logic y0, y1);
  
  assign y0 = i & ~sel;
  assign y1 = i & sel;
  
endmodule 

module fourDeMux(input logic sel0, sel1,
               input logic i,
               output logic y0, y1, y2, y3);
  
  wire z1, z2;
  
  twoDeMux d1(.i(i), .sel(sel0), .y0(z1), .y1(z2));
  twoDeMux d2(.i(z1), .sel(sel1), .y0(y0), .y1(y1));
  twoDeMux d3(.i(z2), .sel(sel1), .y0(y2), .y1(y3));
  
endmodule 

//--------------------------- TestBench ---------------------------//

module fourDeMux_tb;
  
  logic i;
  logic sel0, sel1;
  wire y0, y1, y2, y3;
  
  fourDeMux dut(sel0, sel1, i, y0, y1, y2, y3);
  
  initial begin
    
    $monitor("sel0 = %b sel1 = %b i = %b | y0 = %b y1 = %b y2 = %b y3 = %b", sel0, sel1, i, y0, y1, y2, y3);  
    
    for(int d = 0; d < 2; d++) begin
      sel0 = d;
      
      for(int e = 0; e < 2; e++) begin
        sel1 = e;
        
        for(int f = 0; f < 2; f++) begin
          i = f;
          #1;
        end
      end
    end
    $finish;
  end 
endmodule 
    
