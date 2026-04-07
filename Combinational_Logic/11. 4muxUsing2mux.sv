//--------------------------- Design ---------------------------//

function automatic twoMux(input logic sel, 
                       input logic i0, i1
                        );
  
   twoMux = sel ? i1 : i0;
  
endfunction 

module fourMux(input logic sel0, sel1,
               input logic i0, i1, i2, i3,
               output logic y);
  
  logic y1, y0;
  
  always_comb begin
  
  y0 = twoMux(sel1, i0, i1);
  y1 = twoMux(sel1, i2, i3);
  y = twoMux(sel0, y0, y1);
  end
  
endmodule 
  
//--------------------------- TestBench ---------------------------//

module fourMux_tb;
  
  logic sel0, sel1;
  reg y0, y1, y;
  logic i0, i1, i2, i3;
  
  fourMux dut(sel0, sel1, i0, i1, i2, i3, y);
  
  initial begin
    $monitor("sel0 = %b sel1 = %b i0 = %b i1 = %b i2 = %b i3 = %b y = %b", sel0, sel1, i0, i1, i2, i3, y);
    
    {i3, i2, i1, i0} = 4'h5;
    
    repeat(6) begin
      {sel0, sel1} = $random;
      #5;
      end 
  end
  endmodule 
