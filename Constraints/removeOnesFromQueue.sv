// This contraint code is used to remove 1's from a queue
module tb;
  class noOnes;
    rand bit que [$];
    
    constraint queSize {que.size == 15;}    //The size of the queue should be 15
    
    constraint queVal {
      foreach(que[i])
        que[i] inside {[0:1]};            // The values of elements in the queue should be 1/0
    }
    
    function void post_randomize();
      $display("The initial queue is: %p", que);
      $write("The output after remove ones in queue is: ");
      foreach(que[i]) begin
        if(que[i] == 1)              
          continue;                  //Breaking this loop if the value at que[i] == 1
        else 
          $write("%0b", que[i]);    //Write only non-one values
      end
    endfunction
  endclass
  
  noOnes no = new();
  
  initial begin 
    no.randomize();
  end
endmodule 
