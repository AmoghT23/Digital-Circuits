
//--------------------------- Design ---------------------------//

module fourMux (
    input  logic [1:0] sel,
    input  logic i0, i1, i2, i3,
    output logic y
);

    always_comb begin
        case (sel)
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b11: y = i3;
            default: y = 1'b0;
        endcase
    end

endmodule


//--------------------------- TestBench ---------------------------//

module fourMux_tb;
  
  logic[1:0]sel;
  logic i0, i1, i2, i3;
  wire y;
  
  fourMux dut(sel, i0, i1, i2, i3, y);
  
    initial begin
      $monitor("sel = %b i3 = %b i2 = %b i1 = %b i0 = %b --> y = %b", sel, i3, i2, i1, i0, y);
      {i3, i2, i1, i0} = 4'h5;
      repeat(6) begin
        sel = $random;
        #5;
      end 
    end
endmodule 
