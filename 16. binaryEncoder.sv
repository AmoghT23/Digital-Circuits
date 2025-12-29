//--------------------------- Design ---------------------------//

module binaryEncoder(
  					 input logic [7:0]d,
                     output logic [2:0]y);
  
  assign y[2] = d[4] | d[5] | d[6] | d[7];
  assign y[1] = d[2] | d[3] | d[6] | d[7];
  assign y[0] = d[1] | d[3] | d[5] | d[7];
  
endmodule 

//--------------------------- TestBench ---------------------------//

module binaryEncoder_tb;
  
  logic [7:0]d;
  wire [2:0]y;
  
  binaryEncoder dut(d, y);
  
  initial begin
    d = 8'b1; 
    #1;
    for(int i = 0; i < 8; i++) begin
      $display("d = %h (in dec: %0d) -> y = %h", d, i, y);
      d=d<<1;
      #1;
    end 
  end
endmodule 
