//This replicates the behavior of urandom/shuffle that is similar to 1D sudoku.
module uRandomNo;
  
  class shuffle;
    rand bit [2:0] data [8];

    //Constraint to crosscheck that the data is in range.
    constraint range {
      foreach(data[i])
        data[i] inside{[0:7]};}
    
    //Check the data stored in the array i and j
    constraint shuffledNumber {
      foreach(data[i])
        foreach(data[j])
          if(j>i)
            data[i] != data[j];
    }
     
  endclass
  
  shuffle sh = new();
  
  initial repeat(10) begin
    sh.randomize();
    
    $display("The shuffle/urandom operation using constraint is %p", sh.data);
  end
endmodule 
