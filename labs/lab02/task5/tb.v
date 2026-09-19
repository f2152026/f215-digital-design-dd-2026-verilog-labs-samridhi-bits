// tb.v
// Testbench for 4-bit ALU

module tb;

  // 1. Declare signals
  reg  [3:0] a;
  reg  [3:0] b;
  reg        op;
  wire [3:0] result;

  // 2. Instantiate the DUT
  alu DUT (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // 3. Stimulus block
  initial begin
    $display("Time | a | b | op | result");
    $display("---------------------------");

    // Test 1: Standard Addition
    a = 4; b = 3; op = 0; #10; 
    
    // Test 2: Standard Subtraction 
    // (This catches the blocking/non-blocking bug. If you ran this on the 
    // original buggy code, 'result' would be completely wrong here because 
    // the intermediate variables wouldn't update in time).
    a = 8; b = 3; op = 1; #10; 

    // Test 3: Change ONLY the 'op' bit
    // (This catches the sensitivity list bug. If you ran this on the original 
    // buggy code, 'result' would stay stuck at the subtraction answer because
    // changing 'op' wouldn't trigger the always block).
    a = 8; b = 3; op = 0; #10; 

    // Test 4: Subtraction resulting in zero
    a = 5; b = 5; op = 1; #10;

    $finish;
  end

  // Monitor changes
  initial begin
    $monitor("%4t | %1d | %1d |  %b | %d", $time, a, b, op, result);
  end

endmodule