//This code contains a constraint that helps us to have only N number of consecutive ones and forces all the other bits to be zero. 
module nConsecutiveOnes;
  
  class consecutiveOnes;
    rand bit [7:0] data;
    rand int range;    //Random starting point so that we dont have to hardcode it
    int n = 3;        // N-number of consecutive one's that should be present. 

    //This constraint is to limit the range with respect to the size of the data.
    constraint Crange {
      range inside {[0:(8-n)]};}

    //This constraint helps us to check the range and assign 1's to the derived range. 
    constraint Cdata {
      foreach(data[i]) 
        if(i >= range && i < range+n)
          data[i] == 1;
      else 
        data[i] == 0;
    }
  
  endclass
  
  consecutiveOnes co = new();
  
  initial repeat(5) begin
    co.randomize();
    
    $display("The bit stream is %b", co.data);
    
  end
endmodule 
