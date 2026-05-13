//Design 

module trainFSM (input logic clk, reset,
                 input logic s1, s2, s3, s4, s5,
                 output logic sw1, sw2, sw3,
                 output logic [1:0] da, db);
  
  typedef enum logic [2:0]{ABout, Ain, Bin, Astop, Bstop} state_t;
  state_t current_state, next_state;
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset) 
      current_state <= ABout;
    else
      current_state <= next_state;
  end
  
  always_comb begin
    sw1 = 0;
   sw2 = 0;
   sw3 = 0;
   da  = 2'b00;
   db  = 2'b00;
    case (current_state)
      ABout: begin
        sw1 = 0;
      	sw2 = 0;
      	sw3 = 0;
      	da = 2'b01;
      	db = 2'b01;
      end
      
      Ain: begin
        sw1 = 0;
        sw2 = 0;
      	sw3 = 0;
      	da = 2'b01;
      	db = 2'b01;
      end
      
      Bin: begin
        sw1 = 1;
        sw2 = 1;
        sw3 = 0;
        da = 2'b01;
        db = 2'b01;
      end
      
      Astop: begin
        sw1 = 1;
        sw2 = 1;
        sw3 = 0;
        da = 2'b00;
        db = 2'b01;
      end
      
      Bstop: begin
        sw1 = 0;
        sw2 = 0;
        sw3 = 0;
        da = 2'b01;
        db = 2'b00;
      end
    endcase
  end
  
  always_comb
    begin
      case (current_state) 
        ABout: begin
          if(s1) 
            next_state = Ain;
          else if(s2)
  			next_state = Bin;
          else
            next_state = ABout;
        end
        
        Ain: begin
          if(s4) 
            next_state = ABout;
          else if(s2)
            next_state = Bstop;
          else 
            next_state = Ain;
        end
        
        Bin: begin
          if(s3) 
            next_state = ABout;
          else if(s1)
            next_state = Astop;
          else
            next_state = Bin;
        end
        
        Astop: begin
          if(s3) 
            next_state = Ain;
          else 
            next_state = Astop;
        end
        
        Bstop: begin
          if(s4) 
            next_state = Bin;
          else 
            next_state = Bstop;
        end
        
        default: 
          begin 
            next_state = ABout;
          end
      endcase
    end 
endmodule 


//Testbench
module trainFSM_test;
  logic clk, reset;
  logic s1, s2, s3, s4, s5;
  logic sw1, sw2, sw3;
  logic [1:0] da, db;
  
  trainFSM t1(.*);
  
  always #10 clk = ~clk;
  
  initial begin
    clk = 0;
    s1=0; s2=0; s3=0; s4=0; s5=0;
    reset = 1;
    repeat (2) @(negedge clk);
    reset = 0;
    repeat (10) @(negedge clk);
    s1 = 1;
    repeat (5) @(negedge clk);
    s2 = 1;
    repeat (5) @(negedge clk);
    s4 = 1;
    s1 = 0;
    repeat (5) @(negedge clk);
    $finish;
  end
  
  initial begin
    $dumpfile("trainFSM.vcd");
    $dumpvars(1);
    $display("-----------------------Summary Report-----------------------");
    $display("clk   reset   s1   s2   s3   s4   s5   sw1   sw2   sw3   da   db");
    $monitor("%0t   %b   %b   %b   %b   %b   %b   %b   %b   %b   %b   %2b   %2b", $time, clk, reset, s1, s2, s3, s4, s5, sw1, sw2, sw3, da, db);
    
  end
endmodule 
    
