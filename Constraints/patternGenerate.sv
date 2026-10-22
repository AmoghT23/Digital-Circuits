//This code generates a pattern 1100110011001100

module tb;
  class pattern;
    rand bit [15:0] patt;
    
    constraint cntr {foreach(patt [i])
      //Why 4 ? -> The pattern is changing every 4 bits
      if(i%4==0 || i%4==1)      //i would be 0 through 15 so 0%4=0 => output 1 1%4=1 => output 1 2%4 != 0 => output 0 3%4 != 0 => output 0 
        patt[i] == 1;
      else 
        patt[i] == 0;}
    
    function void display();
      $display("The pattern as per the given is:");
      foreach(patt[i]) begin
        $write("%0b", patt[i]);
      end
    endfunction
   
  endclass
  
  pattern pt = new();
  
  initial begin
    pt.randomize();
    pt.display();
  end
endmodule 
