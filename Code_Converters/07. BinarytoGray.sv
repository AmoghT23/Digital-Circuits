//--------------------------- Design ---------------------------//
module binaryToGray #(parameter N=4)
  (input logic [(N-1):0] binaryIn,
   output logic [(N-1):0] grayOut
  );
  
  reg [(N-2):0] temp;
  
    always_comb begin
      for(int n=0; n<=N-2; n++) begin
        temp[n] <= binaryIn[n+1] ^ binaryIn[n];
      end
    end
  
  assign grayOut = {binaryIn[N-1], temp};
endmodule 

//--------------------------- TestBench ---------------------------//
module binaryToGray_tb;
  
  parameter N = 4;
  logic [N-1:0] grayOut;
  logic [N-1:0] binaryIn;
  
  binaryToGray dut(.*);
  
  initial begin
    
    for(int i=0; i<=(1<<N); i++) begin
      {binaryIn} = i;
      
      #5;
      $display("[%0t] Binary code is %0b and Gray code is %0b", $time, binaryIn, grayOut);
      #5;
    end
    $finish;
  end
endmodule 
