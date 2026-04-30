/*Problem: Odd Value Counter
An odd value counter generates a sequence of odd numbers starting from 1.
On every rising edge of the clock, the counter increments by 2.

When reset is asserted, the counter must restart from 1.*/

module odd_counter (
    input  wire       clk,
    input  wire       reset,
    output reg [7:0]  cnt_o = 4'd1
);
    // Write your code here
    // Do not delete default code
    always @(posedge clk or posedge reset) begin
        if(reset) 
            cnt_o <= 1;
        else if (cnt_o == 4'd15)
            cnt_o <= 4'd3;
        else
            cnt_o <= cnt_o + 2;
    end
endmodule
