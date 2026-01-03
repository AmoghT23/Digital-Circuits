//--------------------------- Design ---------------------------//

module binaryDecoder(input logic [2:0] D,
                       output logic [7:0] y);
  always @(D) begin
    y = 0;
    case(D)
      3'b000: y[0] = 1'b1;
      3'b001: y[1] = 1'b1;	
      3'b010: y[2] = 1'b1;
      3'b011: y[3] = 1'b1;
      3'b100: y[4] = 1'b1;
      3'b101: y[5] = 1'b1;
      3'b110: y[6] = 1'b1;
      3'b111: y[7] = 1'b1;
      default: y = 0;
    endcase 
  end
endmodule 
 
//--------------------------- TestBench ---------------------------//

module binaryDecoder_tb;
  
  logic [2:0]D;
  wire [7:0]y;
  
  binaryDecoder dut(D, y);
  
  initial begin
    $monitor("D = %b -> y = %b", D, y);
    repeat(5) begin;
               D = $random;
               #1;
             end 
  end
endmodule 
