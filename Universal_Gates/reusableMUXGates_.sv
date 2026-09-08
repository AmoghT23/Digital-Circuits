//All gates using Mux
module mux(input logic a, b, sel,
            output logic y);
  
  assign y = sel ? a: b;
  
endmodule 


module gatesMux(input logic in1, in2,
                output logic out_and, out_or, out_aNot, out_bNot,
               out_nand, out_nor, out_xor, out_xnor);
  
  mux andMux(.sel(in2), .a(in1), .b(1'b0), .y(out_and));
  
  mux orMux(.sel(in2), .a(in1), .b(1'b1), .y(out_or));
  
  mux notMuxa(.sel(in1), .a(1'b1), .b(1'b0), .y(out_aNot));
  
  mux notMuxb(.sel(in2), .a(1'b1), .b(1'b0), .y(out_bNot));
  
  mux nandMux(.sel(out_and), .a(1'b0), .b(1'b1), .y(out_nand));

  mux norMux(.sel(out_or), .a(1'b0), .b(1'b1), .y(out_nor));
  
  mux xorMux(.sel(in2), .a(out_aNot), .b(in1), .y(out_xor));
  
  mux xnorMux(.sel(out_xor), .a(1'b0), .b(1'b1), .y(out_xnor));
  
endmodule 


//Testbench

module tb;
  
  logic in1, in2;
  logic out_and, out_or, out_aNot, out_bNot,
               out_nand, out_nor, out_xor, out_xnor;
  
  gatesMux dut(.*);
  
  initial begin
    
    $dumpfile("gatesMux.vcd");
    $dumpvars(1);
    
    for(int i=0; i<5; i++) begin
      {in1, in2} = i;
      #5;
      
    end
    $finish;
  end
  
endmodule 
  
