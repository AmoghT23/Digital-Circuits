module kmap_circuit (
    input a,
    input b,
    input c,
    output out
);

    // Write your code here
    assign out = ~a&b | a&~b;
endmodule
