//Design 

module crcGenerator#(parameter int DWIDTH = 8, 
         parameter int CWIDTH = 32, 
         parameter logic [CWIDTH-1:0]INIT = '1,
         parameter logic [CWIDTH-1:0]XOR_OUT = '1,
         parameter logic [CWIDTH-1:0]POLY = 32'hEDB88320)
  
  (input logic clk, rstn, 
   input logic start, dataValid,
   input logic [(DWIDTH-1):0] dataIn,
   input logic dataLast,
   output logic [(CWIDTH-1):0] crcOut,
   output logic crcValid);
  
  
  logic [(CWIDTH-1):0] crcReg;
  logic [(CWIDTH-1):0] crcNext;
  
  function automatic logic [CWIDTH-1:0] crcUpdate(
    input logic [CWIDTH-1:0] crc, 
    input logic [DWIDTH-1:0] data);
    
    logic [CWIDTH-1:0] temp;
    logic feedback;
    
      temp = crc;
    
    for(int i=0; i<DWIDTH; i++) begin
      feedback = temp[0] ^ data[i];
      temp = temp >> 1;
      
      if(feedback) 
        temp = temp ^ POLY;
    end
    
      return temp;

    endfunction;
  
    always_comb begin
    crcNext = crcUpdate(crcReg, dataIn);
  end
    
  always_ff @(posedge clk, negedge rstn) begin
    if(!rstn) begin
      crcReg <= INIT;
    end else if (start) begin
      crcReg <= INIT;
    end else if(dataValid) begin
      crcReg <= crcNext;
    end
  end
  
  always_ff @(posedge clk, negedge rstn) begin
    if(!rstn) begin 
      crcOut <= '0;
      crcValid <= 1'b0;
    end else begin
    	crcValid <= 1'b0;
    	
      if(dataValid && dataLast) begin
        crcOut <= crcNext ^ XOR_OUT;
        crcValid <= 1'b1;
      end
    end
  end
  
endmodule 


//Class Based TestBench

class Transaction;
  rand int unsigned num_bytes;
  rand bit [7:0] data [];
  
  constraint cNumBytes {num_bytes inside {[1:20]};}
  
  constraint cdata {data.size() == num_bytes;}
endclass


module tb;
  parameter int DWIDTH = 8; 
  parameter int CWIDTH = 32; 
  parameter logic [CWIDTH-1:0]INIT = '1;
  parameter logic [CWIDTH-1:0]XOR_OUT = '1;
  parameter logic [CWIDTH-1:0]POLY = 32'hEDB88320;
  
  
  logic clk, rstn;
  logic start, dataValid;
  logic [(DWIDTH-1):0] dataIn;
  logic dataLast;
  logic [(CWIDTH-1):0] crcOut;
  logic crcValid;
  
  
  crcGenerator dut(.*);
  

  always #5 clk = ~clk;
  
  
	Transaction tr;
  
  initial begin
    
    tr = new();
    
    clk = 0;
    rstn = 0;
    start = 0;
    dataValid = 0;
    dataIn = 0;
    dataLast = 0;
    
    #10;
    rstn = 1;
    
    @(negedge clk);
    start = 1;
    
    @(negedge clk);
    start = 0;
    
    repeat(5) begin
    
    if(!tr.randomize()) 
      $fatal("Randomization FAILED");
    
    $display("Number of bytes = %0d", tr.num_bytes);
    
      foreach(tr.data[i]) begin
        
        $display("data[%0d] = %02h", i, tr.data[i]);
        
        if(i == tr.num_bytes-1) 
          send_bytes(tr.data[i], 1);
        else 
          send_bytes(tr.data[i], 0);
      end
      
      wait(crcValid);
      
      $display("DUT CRC = %08h", crcOut);
      
    end
    $finish;
  end
  
               task send_bytes (input logic [7:0] byte_data,
                                input logic last);
                 
                 begin 
                   @(negedge clk)
                   dataIn = byte_data;
                   dataValid = 1'b1;
                   dataLast = last;
                   
                   @(posedge clk);
                   
                   dataValid = 0;
                   dataLast = 0;
                 end
               endtask
  
endmodule 
