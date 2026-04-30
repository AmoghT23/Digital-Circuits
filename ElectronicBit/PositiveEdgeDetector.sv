/*Problem Description

Design a simple circuit that pulses the output on every rising edge of the input.

A positive edge detector will send out a pulse whenever the signal it is monitoring changes from 0 to 1.

Example:

Input Signal: 1 0 1 1 0

Output: 0 0 1 0 0

Note: The input signal transitions from 0 to 1 in the 3rd clock cycle, so we detect a +ve edge there and will output 1 at that time. */

module pos_edge_det (
    input sig,   // Input signal for which positive edge has to be detected
    input clk,   // Input signal for clock
    input rstn,  // Input signal for reset
    output pe    // Output signal that gives a pulse when a positive edge occurs
);

    reg sig_delay;

// Write Your Code Here
// Do not remove default code
    always @(posedge clk or negedge rstn) begin
        if(!rstn) 
        sig_delay <= 1'b0;
        else 
        sig_delay <=1'b1;
    end

        assign pe = sig & (~sig_delay);
endmodule
