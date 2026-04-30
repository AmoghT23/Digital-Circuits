/*Problem Description

Design a simple circuit that pulses the output on every falling edge of the input.

A negative edge detector will send out a pulse whenever the signal it is monitoring changes from 1 to 0.

Example:

Input Signal: 1 1 0 1 0

Output: 0 0 1 0 1

Note: The input signal transitions from 1 to 0 in the 3rd clock cycle and 5th cycle, so we detect a -ve edge there and we will output 1 at that time.*/

module neg_edge_det ( 
    input sig,   // Input signal for which negative edge has to be detected
    input clk,   // Input signal for clock
    input rstn,  // Input signal for reset
    output ne    // Output signal that gives a pulse when a negative edge occurs
);
    reg sig_d;

// Write Your Code Here
// Do not remove default code

    always @(posedge clk or negedge rstn) begin
        if(!rstn)
            sig_d <= 1'b1;
        else
            sig_d <= 1'b0;
    end

    assign ne = sig & (~sig_d);
endmodule
