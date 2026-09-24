//The constraint and the code essetially checks that no 2 ones (1's) are consecutive.

module noTwoAdjecentOnes;
  
  class noAdjOnes;
    rand bit [7:0] data;

    //This constraint checks for all the data elements in the array data when i > 0. ith element of data and i-1st element of data should'nt be 1.
    constraint cData {
      foreach(data[i]) 
        if(i>0)
          !(data[i] && data[i-1]);
    }
  endclass
  
  noAdjOnes nao = new();
  
  initial repeat(5) begin
    nao.randomize;
    
    $display("The data array with no consecutive ones is %b", nao.data);
  end
endmodule 
