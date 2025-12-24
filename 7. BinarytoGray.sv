//--------------------------- Design ---------------------------//
module binaryGray #(parameter WIDTH = 4)(
  input  logic [WIDTH:0] A,
  output logic [WIDTH:0] G
);

  genvar i;

  assign G[WIDTH] = A[WIDTH];

  generate
    for (i = 0; i < WIDTH; i++) begin
      assign G[i] = A[i+1] ^ A[i];
    end
  endgenerate

endmodule


//--------------------------- TestBench ---------------------------//

module binaryGray_tb #(parameter WIDTH = 4);

  logic [WIDTH-1:0] A;
  logic [WIDTH-1:0] G;

  // DUT instantiation
  binaryGray #(WIDTH-1) dut (
    .A(A),
    .G(G)
  );

  initial begin
    for (int i = 0; i < (1 << WIDTH); i++) begin
      A = i;
      #1;
      $display("A = %b | G = %b", A, G);
    end
    $finish;
  end

endmodule
