/* Problem Description

Write a code for Fibonacci Series Generator starting with 1 and 1 as its first two numbers. The next number is found by adding up the two numbers before it.

S(0) = 1

S(1) = 1

S(n) = S(n-1) + S(n-2) for n > 1

Assume reset is negative edge triggered and asynchronous.

Example: Fibonacci Sequence: 1 1 2 3 5 8. If we run the Fibonacci sequence generator for 6 cycles, it should generate the above sequence.*/

module Fibonacci_generator #(parameter
  DATA_WIDTH=32
) (
  input clk,
  input resetn,
  output [DATA_WIDTH-1:0] out
);
//Write Your Code Here
//Do not remove default code

reg [DATA_WIDTH-1:0] prev1, prev2;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      prev1 <= 1;
      prev2 <= 1;
    end else begin
      prev1 <= prev1 + prev2;
      prev2 <= prev1;
    end
  end

  assign out = prev2;

   
endmodule
