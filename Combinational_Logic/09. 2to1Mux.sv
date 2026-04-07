//--------------------------- Design ---------------------------//

module twoMux (input logic i0, i1,
               input logic sel,
               output logic y);
  
  assign y = sel ? i0 : i1;
  
endmodule 

//--------------------------- TestBench ---------------------------//

module twoMux_tb;
  
  logic i0, i1;
  logic sel;
  wire y;
  
  twoMux dut(i0, i1, sel, y);
  
  initial begin
    $monitor("sel = %h: i0 = %h, i1 = %h --> y = %h", sel, i0, i1, y);
    i0 = 0;
    i1 = 1;
    
    #1;
    sel = 0;
    
    #1;
    sel = 1;
    
  end 
endmodule
