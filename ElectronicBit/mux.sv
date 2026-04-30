//Write a verilog code for mux logic, having input as "a", "b" and "sel". Giving out as "a" with sel = 0 and out as "b" with sel = 1

//Try solving the question with two approach.

module mux (
    input a,
    input b,
    input sel,
    output out
);
    // Write Your Code Here
    // Do not remove default code

    assign out = sel ? b:a;
endmodule
