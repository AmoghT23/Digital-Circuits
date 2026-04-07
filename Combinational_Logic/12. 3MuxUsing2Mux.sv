//--------------------------- Design ---------------------------//

function automatic twoMux(input logic sel, 
                   input logic i0, i1);
  
  twoMux = sel ? i1 : i0;
  
endfunction

module threeMux(input logic sel0, sel1,
                input logic i0, i1, i2,
                output logic y);
  
  logic y0;
  
  always_comb begin
    
  y0 = twoMux(sel1, i0, i1);
  y = twoMux(sel0, y0, i2);
  end
  
endmodule 
  
//--------------------------- TestBench ---------------------------//

module threeMux_tb;
  
  logic i0, i1, i2;
  logic sel0, sel1;
  wire y;
  
  threeMux dut(sel0, sel1, i0, i1, i2, y);
  
  initial begin
    
    $monitor("sel0 = %b sel1 = %b i0 = %b i1 = %b i2 = %b y = %b", sel0, sel1, i0, i1, i2, y);
    
    {i2, i1, i0} = 4'h5;
    
    repeat(8) begin
      {sel0, sel1} = $random;
      #5;
    end 
  end
endmodule 
