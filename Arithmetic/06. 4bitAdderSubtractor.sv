//--------------------------- Design ---------------------------//

function automatic [1:0] adder (input logic a, b, 
                       input logic cin
                       );
  
  adder = {((a & b) | (b & cin) | (cin & a)), a ^ b ^ cin
          };
endfunction

module rippleCarrySubtractor #(parameter SIZE = 4) (
    input  logic [SIZE-1:0] A, B,
    input  logic CTRL,           
    output logic [SIZE-1:0] S,
    output logic Cout             
);

    logic [SIZE-1:0] Bc;
    logic [SIZE:0]   carry;
    genvar g;

    assign Bc = B ^ {SIZE{CTRL}};

    assign carry[0] = CTRL;

    generate
        for (g = 0; g < SIZE; g++) begin
            assign {carry[g+1], S[g]} =
                   adder(A[g], Bc[g], carry[g]);
        end
    endgenerate

    assign Cout = carry[SIZE];

endmodule

//--------------------------- TestBench ---------------------------//

module rippleCarrySubtractor_tb;

  parameter SIZE = 4;

  logic [SIZE-1:0] A, B;
  logic [SIZE-1:0] S;
  logic            Cout;
  logic            CTRL;

  rippleCarrySubtractor #(SIZE) dut (.*);

  class stim;
    rand logic [SIZE-1:0] A, B;
    rand logic            CTRL;

    constraint range {
      A inside {[0:(1<<SIZE)-1]};
      B inside {[0:(1<<SIZE)-1]};
    }
  endclass

  stim s;

  initial begin
    // Initialize inputs
    A = '0;
    B = '0;
    CTRL = 1'b0;

    s = new();

    repeat (20) begin
      assert(s.randomize())
        else $fatal("Randomization failed");

      A    = s.A;
      B    = s.B;
      CTRL = s.CTRL;

      #10;

      if (CTRL == 0)
        $display("ADD: A=%0d B=%0d | S=%0d Cout=%0d",
                  A, B, S, Cout);
      else
        $display("SUB: A=%0d B=%0d | S=%0d Carry=%0d",
                  A, B, S, Cout);
    end

    $finish;
  end

endmodule
