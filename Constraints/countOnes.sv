//Replicate the $countones. Used when we want a specific number of ones in an array.
module onesCount;
  
  class ones;
    rand bit [7:0] num;

    //Hard coded constraint as systemverilog doesnt allow us to write procedural operations.
    constraint numC {
      num[0] + num[1] + num[2] + num[3] + 
      num[4] + num[5] + num[6] + num[7] == 4;}
        
  endclass
  
  ones oc = new();
  
  initial repeat(5) begin
    
    oc.randomize();
    
    $display("The num array = %b", oc.num); 
    
  end
endmodule 
      
        
      
