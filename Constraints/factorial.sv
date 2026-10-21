module tb;
  class factorialNo;
    rand int unsigned num;
    rand int unsigned fact;
    
    constraint cFact {num inside {[1:20]};}
    constraint cValue {fact==fun(num);};

    //!0 = 1
    function automatic int fun(int num);
      if(num == 0)
        return 1;
      else 
        return num*fun(num-1);    //!n = n * (n-1) *(n-2) ......
    endfunction
    
    function void post_randomize();
      $display("num = %0d | factorial = %0d", num, fact);
    endfunction
    
  endclass
  
  factorialNo fn = new();
  
  initial repeat(5) begin
    fn.randomize();
  end
endmodule 
