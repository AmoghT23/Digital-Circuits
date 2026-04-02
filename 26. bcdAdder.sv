//--------------------------- Design ---------------------------//

module bcdAdder (input logic [3:0] a, b, 
                 output logic [3:0] sum, 
                 output logic cout);
  
  wire [4:0] decsum;
  wire [3:0] diff;
  
  
  assign decsum = a+b;
  assign cout = decsum > 9;
  assign diff = decsum + 6;
  assign sum = cout ? diff : decsum;
  
endmodule 

//--------------------------- TestBench ---------------------------//

module bcdAdder_tb;
  
  logic [3:0] a, b;
  logic [3:0] sum;
  logic cout;
  
  reg [4:0] decsum;
  reg [3:0] diff;
  
  bcdAdder dut(.*);
  
  initial begin
    
    repeat (100) 
      begin
      a=$urandom();
    b=$urandom();
    #1;
    $display("a=%0d b=%0d | sum=%0d cout=%0d", a, b, sum, cout);
  end
    a=9; b=9;
    #1;
  	$display("a=%0d b=%0d | sum=%0d cout=%0d", a, b, sum, cout);
  end 
endmodule 
