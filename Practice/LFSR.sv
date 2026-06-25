//Design 
module lfsr_fpga(
  input logic clk, rst, 
  input logic mode,
  output logic [7:0] q);
  
  logic [7:0] q_next;
  logic [7:0] q_f, q_g;
  reg [24:0] counter;
  reg tick;
  
  always_ff @(posedge clk, negedge rst) begin
	if(!rst) 
		counter <= '0;
	else if (counter == 25000000)
		counter <= '0;
	else 
		counter <= counter + 1'b1;
	end
	
  assign tick = (counter == 25000000);
  
  always_ff @(posedge clk, negedge rst) begin
    if(!rst) 
      q <= 8'b00000001;
    else if(tick) 
      q <= q_next;
  end
  
  always_comb begin
    logic feedback;
  	feedback = (q[7] ^ q[0]) ^ (q[5] ^ q[6]);
    
    q_f = {q[6:0], feedback};
  end
  
  always_comb begin
    logic [7:0] shifted;
    
    shifted = {q[6:0], 1'b0};
      
    q_g = q[7] ? (shifted ^ 8'b00000111) : shifted;
  end
  
  assign q_next = (mode) ? q_f: q_g;
endmodule 

//Testbench
module LFSR_tb;
  
  logic clk, rstn;
  logic mode;
  logic [7:0] q;
  
  LFSR dut (.*);
  
  always #5 clk = ~clk;
  
  initial begin
    clk=0;
    rstn=0;
    
    #12;
    rstn=1;
    #5;
    mode = 0;
    repeat(20) begin
      @ (posedge clk); 
      
      $display("[%0t] q=%08b", $time, q);
      
      assert property (
        @(posedge clk) 
        disable iff(!rstn)
        q != 8'b00000000
      );
    end
        
        #10;
        mode = 1;
        repeat(20) begin
      @ (posedge clk); 
      
      $display("[%0t] q=%08b", $time, q);
      
      assert property (
        @(posedge clk) 
        disable iff(!rstn)
        q != 8'b00000000
      );
    end
        
    $finish;
  end
endmodule 
        
        
        
        
