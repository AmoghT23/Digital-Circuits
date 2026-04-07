//--------------------------- Design ---------------------------//

module fourdemux(
  input  logic       i,
  input  logic [1:0] sel,
  output logic       y0, y1, y2, y3
);

  always_comb begin
    {y0, y1, y2, y3} = 4'b0000;

    case (sel)
      2'b00: {y0, y1, y2, y3} = {i, 3'b000};
      2'b01: {y0, y1, y2, y3} = {1'b0, i, 2'b00};
      2'b10: {y0, y1, y2, y3} = {2'b00, i, 1'b0};
      2'b11: {y0, y1, y2, y3} = {3'b000, i};
    endcase
  end

endmodule

//--------------------------- TestBench ---------------------------//

module fourdemux_tb;
  
  logic [0:1] sel;
  logic i;
  wire y0, y1, y2, u3;
  
  fourdemux dut(i, sel, y0, y1, y2, y3);
  
  initial begin
    $dumpfile("fourdemux_tb.vcd");
    $dumpvars(0, fourdemux_tb);
    
    $monitor("sel = %b i = %b y0 = %b y1 = %b y2 = %b y3 = %b", sel, i, y0, y1, y2, y3);
    
    for(int d=0; d<4; d++)begin
      sel = d[1:0];
      for(int k=0; k<2; k++) begin
        i = k;
        #1;
      end 
    end
    $finish;
  end 
endmodule 
