module carryLookAhead #(parameter WIDTH=4) 
            (input logic [WIDTH-1:0] a, b,
             input logic cin,
             output logic [WIDTH-1:0] sum, 
             output logic cout);
  
  logic [WIDTH-1:0] g, p;
  logic [WIDTH:0]c;
  assign c[0] = cin;
    
  	genvar i;
  		generate 
          for(i=0; i<WIDTH; i++) begin
            assign g[i] = a[i] & b[i];
            assign p[i] = a[i] ^ b[i];
          end
        endgenerate
  
  generate
    for(i=0; i<WIDTH; i++) begin
      assign c[i+1] = g[i] | (p[i] & c[i]);
    end
  endgenerate 
  
  generate 
    for(i=0; i<WIDTH; i++) begin
      assign sum[i] = p[i] ^ c[i];
    end
  endgenerate 
  
  assign cout = c[WIDTH];
endmodule 

//TB
module carryLookAhead_tb #(parameter WIDTH=4);

  logic [WIDTH-1:0] a, b;
  logic cin;
  logic [WIDTH-1:0] sum;
  logic cout;
  logic [WIDTH:0] expected;

  carryLookAhead dut(.*);

  initial begin
    $dumpfile("dumps.vcd");
    $dumpvars(0, carryLookAhead_tb);

    repeat (512) begin
      a = $random() % (1 << WIDTH);
      b = $random() % (1 << WIDTH);
      cin = $random() % 2;

      #1;
      expected = a + b + cin;

      if ({cout, sum} !== expected) begin
        $display("ERROR: a=%0d b=%0d cin=%0d | expected=%0d actual=%0d", a, b, cin, expected, {cout, sum});
      end
      else begin
        $display("PASS!: a=%0d b=%0d cin=%0d | expected=%0d actual=%0d", a, b, cin, expected, {cout, sum});
    end
    $display("Test completed");
  end
  end
endmodule
