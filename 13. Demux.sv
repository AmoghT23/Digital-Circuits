//--------------------------- Design ---------------------------//

module demux(input logic i,
             input logic sel,
             output logic y0,y1);
  
  assign {y0, y1} = sel ? {1'b0, i} : {i, 1'b0};
  
endmodule
  
//--------------------------- TestBench ---------------------------//

module demux_tb;
  
  logic i;
  logic sel;
  wire y0, y1;
  
  demux dut(i, sel, y0, y1);
  
  initial begin
    $dumpfile("demux_tb.vcd");
    $dumpvars(0, demux_tb);
    $monitor("sel = %h i = %h y0 = %h y1 = %h", sel, i, y0, y1);
    for (int j=0; j<=1; j++) begin
      sel = j;
      for(int k=0; k<=1; k++) begin
        i = k; 
    #1;
      end
    end
    $finish;
  end
  
endmodule 
