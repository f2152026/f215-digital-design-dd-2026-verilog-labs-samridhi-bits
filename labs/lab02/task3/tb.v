// tb.v
// Self-checking testbench for 2-bit comparator

module tb;

  // 1. Declare signals
  reg  [1:0] A;
  reg  [1:0] B;
  wire       GT;
  wire       LT;
  wire       EQ;

  // 2. Instantiate the Device Under Test (DUT)
  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  // Integers to use in our for-loops
  integer i, j;

  // Optional: Waveform dump configuration (if you still want to view the VCD file)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // 3. Stimulus and Self-Checking Block
  initial begin
    $display("Starting tests...");

    // Loop through all 4 possible values for A (0 to 3)
    for (i = 0; i < 4; i = i + 1) begin
      // Loop through all 4 possible values for B (0 to 3)
      for (j = 0; j < 4; j = j + 1) begin
        
        // Apply inputs
        A = i;
        B = j;
        
        // Wait 10 time units for the combinational logic to update
        #10; 

        // SELF-CHECKING LOGIC:
        // Check if A == B
        if (A == B) begin
          if (EQ !== 1'b1 || GT !== 1'b0 || LT !== 1'b0)
            $display("ERROR: A=%0d, B=%0d | Expected: EQ=1, GT=0, LT=0 | Got: EQ=%b, GT=%b, LT=%b", A, B, EQ, GT, LT);
        end
        
        // Check if A > B
        else if (A > B) begin
          if (GT !== 1'b1 || EQ !== 1'b0 || LT !== 1'b0)
            $display("ERROR: A=%0d, B=%0d | Expected: GT=1, EQ=0, LT=0 | Got: EQ=%b, GT=%b, LT=%b", A, B, EQ, GT, LT);
        end
        
        // Check if A < B
        else if (A < B) begin
          if (LT !== 1'b1 || EQ !== 1'b0 || GT !== 1'b0)
            $display("ERROR: A=%0d, B=%0d | Expected: LT=1, EQ=0, GT=0 | Got: EQ=%b, GT=%b, LT=%b", A, B, EQ, GT, LT);
        end

      end
    end

    $display("Simulation finished.");
    $finish;
  end

endmodule