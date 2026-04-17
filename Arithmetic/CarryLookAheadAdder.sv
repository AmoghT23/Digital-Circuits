module carryLookAhead #(parameter WIDTH=4) 
            (input logic [WIDTH-1:0] a, b,
             input logic cin,
             output logic [WIDTH-1:0] sum, 
             output logic cout);
  
  logic [WIDTH-1:0] g, p;
  logic [WIDTH:0]c;
  assign c[0] = 0;
    
  	genvar i;
  		generate 
          for(i=0; i<WIDTH; i++) begin
            assign g[i] = a&b;
            assign p[i] = (a^b);
          end
        endgenerate
  
  assign c[1] = g[1] | (p[1]&c[0]);
  assign c[2] = g[1] | (p[1]&g[0]) | (p[1]&p[0]&c[0]);
  assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&c[0]);
  assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&p[0]&c[0]);
  
  generate
    for(i=0; i<WIDTH; i++) begin
      assign sum[i] = p[i] ^ c[i];
    end
  endgenerate 
  
  assign cout = c[WIDTH];
endmodule 

//TB
module carryLookAhead_tb #(parameter WIDTH=4) ;
  
  logic [WIDTH-1:0] a, b;
  logic cin;
  logic [WIDTH-1:0] sum;
  logic cout;
  logic expected = 0;
  
  carryLookAhead dut(.*);
  
  initial begin
    $dumpfile("dumps.vcd");
    $dumpvars(1);
    
    repeat (512) begin
      a = $random();
      b = $random();
      cin = $random();
      
      #1;
      $display ("a=%0d b=%0d cin=%0d | sum=%0d cout=%0d ", a, b, cin, sum, cout);
      #1;
    end
  end
endmodule 
