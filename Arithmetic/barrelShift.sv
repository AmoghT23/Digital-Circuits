module barrelShift #(parameter WIDTH = 8)
  (input logic [WIDTH-1:0] data_in,
   input logic [$clog2(WIDTH)-1:0] shift_amt,
   input logic [1:0] mode,
   output logic [WIDTH-1:0] data_out);
  
  always_comb begin
    case(mode)
      2'b00:data_out = data_in << shift_amt;
      2'b01:data_out = data_in >> shift_amt;
      2'b10:data_out = (data_in << shift_amt) | (data_in >> (WIDTH - shift_amt));
      2'b11:data_out = (data_in >> shift_amt) | (data_in << (WIDTH - shift_amt));
      default: data_out = data_in;
    endcase
  end
endmodule 


//TB
module barrelShift_tb #(parameter WIDTH = 8);
  
  logic [WIDTH-1:0] data_in;
  logic [$clog2(WIDTH)-1:0] shift_amt;
  logic [1:0] mode;
  logic [WIDTH-1:0] data_out;
  
  barrelShift dut(.*);
  
  initial begin
    $dumpfile("barrelShift.vcd");
    $dumpfile(1);
    
    repeat (10) begin
    data_in = $urandom;
    shift_amt = $urandom;
    mode = $urandom;
  	
    #5;
      
      $display("data_in=%0d shift_amt=%0d mode=%0d | data_out=%0d", data_in, shift_amt, mode, data_out);
      #5;
    end
  end
endmodule
