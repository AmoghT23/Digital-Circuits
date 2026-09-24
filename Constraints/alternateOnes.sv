//This code helps to generate alternate 1s in a given sequence. 

module altBits;
  
  class alternate;
    rand bit [7:0] data;

    //Constraint stating for each element in the data array while the i > 0, ith element of the array data should not be equal to the previous element data.
    constraint Cdata {
      foreach(data[i]) 
        if(i > 0)
          data[i] != data[i-1];}
    
  endclass
  
  alternate al = new();
  
  initial repeat (5)begin
    al.randomize();
    
    $display("The alternating data array is %b", al.data);
  end
endmodule
