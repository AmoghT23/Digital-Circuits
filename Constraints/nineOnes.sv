//Constraint for only 9bits in the array should be 1 and there should be no 111 or 000

module tb;
  class pattern;
    rand bit [15:0]addr;
    
    constraint cntOnes {$countones(addr) == 9;}
    
    constraint not_in {
      foreach(addr[i])
        if(i<14) {
          {addr[i], addr[i+1], addr[i+2]} != 3'b000;
          {addr[i], addr[i+1], addr[i+2]} != 3'b111;
        }
        }
          
          function void display();
      $display("The addr is: %0p", addr);
      $display("Count the no. of ones in the addr: %0d", $countones(addr));
      $display("The bits in the addr:");
      foreach(addr[i]) begin
        $write("%0b", addr[i]);
      end
      endfunction
      endclass
      
      pattern pt = new();
      
      initial begin
        repeat (5) begin
        pt.randomize();
        pt.display();
        end
      end
      endmodule 
