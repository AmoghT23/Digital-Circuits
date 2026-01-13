//--------------------------- Design ---------------------------//

module SRFlipflop(input logic clk, rstn,
                  input logic s, r,
                  output logic q,
                  output logic q_bar);
  
  always @(posedge clk) begin
    if(!rstn) 
      q<=0;
    else begin
      case({s, r}) 
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
      endcase
    end
    end
    assign q_bar = ~q;
    endmodule

//--------------------------- TestBench ---------------------------//

module SRFlipflop(input logic clk, rstn,
                  input logic s, r,
                  output logic q,
                  output logic q_bar);
  
  always @(posedge clk) begin
    if(!rstn) 
      q<=0;
    else begin
      case({s, r}) 
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
      endcase
    end
    end
    assign q_bar = ~q;
    endmodule
