/*To perform division by 2 with using % */

module evenNumber;
  
  class eNumber;
    rand bit [7:0] data;
    
    constraint evenDataC {data[0] == 0;}
    //constraint evenDataC4 {data[1:0] == 2'b00;}        -- For divisible by 4. We will also have to change the if case in the initial loop.
    
  endclass 
  
  eNumber en = new();
  
  initial repeat(5) begin
    en.randomize();
    
    if(en.data % 2==0) 
      $display("data = %0d is divisible by 2", en.data);
    else 
      $display("data = %0d is not divisible by 2", en.data);
  end
endmodule 
