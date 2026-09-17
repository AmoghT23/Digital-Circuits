//This class with constraint replicates the behaviour of unique() without using the built-in. 

module uniqueData;

class uniqueElements;
  rand bit [7:0] data[8];
  
  constraint noDuplicate {
    foreach(data[i])
      foreach(data[j])
        if(j > i)  //This checks if the index of the unpacked array is greater than the index of packed array.        
          data[i] != data[j]; //Check the basic condition that both the numbers are not same.
  }
endclass
  
  uniqueElements ue = new();
  
  initial repeat (10) begin
    ue.randomize();
    
    $display("The Unique Elements of array are %p", ue.data);
  end
endmodule 
