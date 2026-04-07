//--------------------------- Design ---------------------------//

module grayBinary #(parameter WIDTH = 4)
  
  (input logic [WIDTH:0]G,
   output logic [WIDTH:0]B);
  
  genvar i;
  
  assign B[WIDTH] = G[WIDTH];
  
  generate 
    for(i=0; i < WIDTH; i++) begin
      assign B[i] = ^G[WIDTH : i];
    end
  endgenerate 
endmodule 

//--------------------------- TestBench ---------------------------//

module grayBinary_tb #(parameter WIDTH = 4);
  
  logic [WIDTH-1:0] G;
  logic [WIDTH-1:0] B;
  
  grayBinary #(WIDTH) dut(.*);
  
  initial begin
    for(int i = 0; i < (1<<(WIDTH+1)); i++) begin
      G = i;
      
      #1;
      $display("G = %b | B = %b", G, B);
    end
    $finish;
  end 
endmodule 
