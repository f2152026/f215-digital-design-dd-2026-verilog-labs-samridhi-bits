// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

    reg [1:0] sel;
    wire [7:0] dout;

    // Instantiate DUT
    lut DUT (
        .sel(sel),
        .dout(dout)
    );

    // Waveform dump configuration (DO NOT CHANGE)
    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    initial begin
        sel = 0; #10;
        sel = 1; #10;
        sel = 2; #10;
        sel = 3; #10;

        $finish;
    end

    initial
        $monitor($time, " sel=%0d dout=%0d", sel, dout);

endmodule