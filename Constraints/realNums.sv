//Randomize the num and constraint it between 3.5 and 5.5
module tb;
  class realVal;
    rand int rel_num;
    real num;
    
    constraint cnum1 {
      rel_num inside {[35:55]};}
    
    function post_randomize();
      num = rel_num / 10.0;
      $display("The real number is: %0f", num);
    endfunction 
    
  endclass
  
  realVal rl = new();
  
  initial repeat (5) begin
    rl.randomize();
  end
endmodule 
