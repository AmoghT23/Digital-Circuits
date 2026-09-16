//The main objective of this is to replicate the behavior of randc (cyclic randomization) using simple rand (randomize). 
module randc_tb;

class RandcClass;
  rand bit [3:0] addr;
  
  bit[3:0] used [$];
  
  constraint noRepeat { !(addr inside {used});}    //To check for no duplicates in the queue. 
  
  function void post_randomize();    
    used.push_back(addr);      //Push-back the contents after randomization 
    
    if(used.size() == 16)    //16 is based on the size of the array. We can have any Number in the range for better controllability. ([3:0] = 16 values)
      used.delete();          //After 16 numbers delete the queue and then start another cycle. 
  endfunction
endclass
  
  RandcClass rc = new();
  
  initial repeat (20) begin
    if(!rc.randomize())
    	$error("Randomization failed");
    #2;
    $display("The Address is: 0x%0h", rc.addr);
  end
                       
endmodule 
