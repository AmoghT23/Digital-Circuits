//The objective of this code is to check for no repeatition in 4 consecutive numbers  

module noRepeat_tb;
  
  class noRepeat;
    rand bit [2:0] value;
    bit [2:0] history [$];		//Create a queue to add all the elements to check for no repeatation.
    
    constraint noRecentRepeat {!(value inside {history});} 	//Constraint to check that the values is not already present in the queue
    
    function void post_randomize();
      history.push_back(value);		
      
      if(history.size() > 4)	//The repeatition should not be observed in 4 consecutive elements. 
    //if(history.size == 16)  this will show similar characteristics like randc
        history.pop_front ();
    endfunction
    
  endclass
  
  noRepeat nr = new();
  
  initial repeat(10) begin
    if(!nr.randomize()) 
      $error("Randomization failed");
    
    #2;
    $display("The value is %0d", nr.value);
  end
endmodule 
    
