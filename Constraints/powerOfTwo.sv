//Powers of two. Similar to a oneHot code but to get all the powers of 2

module powerTwo;
  
  class power;
    rand bit [7:0] data;

//Countones can be used but as we dont want to use any constructs we can do a hardcode value.
    constraint cData {
      data[0] + data[1] + data[2] + data[3] + 
      data[4] + data[5] + data[6] + data[7] == 1;
    }
    
  endclass
  
  power pw = new();
  
  initial repeat (9) begin
    pw.randomize();
    
    $display("The powers of two are %0d", pw.data);
  end
  
endmodule 
