module shiftReg #(parameter N=4) (
  input  logic clk, rstn,
  input  logic d_in,
  output logic [N-1:0] q
);

  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn)
      q <= '0;
    else
      q <= {q[N-2:0], d_in}; // shift left, new bit enters LSB
  end

endmodule


///TB
module shiftReg_tb #(parameter N = 4);
  
  logic clk, rstn;
  logic d_in;
  logic [N-1:0]q;
  
  shiftReg #(.N(N)) dut(.*);
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("shiftReg.vcd");
    $dumpvars(1);
    d_in =0;
    clk =0;
    rstn=0;
    
    repeat(2) @(posedge clk);
    
    rstn=1;
    for(int i=0; i<(N*2); i++) begin
      d_in = i[0];
      @(posedge clk); 
      $display("d=%0b rstn=%0b | q=%0b", d_in, rstn, q);
    end 
          $finish;
  end
endmodule 
