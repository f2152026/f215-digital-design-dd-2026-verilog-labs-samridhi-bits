module tb;

    // DUT inputs
    reg t_i0, t_i1, t_s;

    // DUT output
    wire t_y;

    // Instantiate DUT
    DUT DUT(
        .I0(t_i0),
        .I1(t_i1),
        .S(t_s),
        .Y(t_y)
    );

    // Waveform dump configuration
    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    // Stimulus block
    initial begin
        t_s = 0; t_i1 = 0; t_i0 = 0; #10;
        t_s = 0; t_i1 = 0; t_i0 = 1; #10;
        t_s = 0; t_i1 = 1; t_i0 = 0; #10;
        t_s = 0; t_i1 = 1; t_i0 = 1; #10;

        t_s = 1; t_i1 = 0; t_i0 = 0; #10;
        t_s = 1; t_i1 = 0; t_i0 = 1; #10;
        t_s = 1; t_i1 = 1; t_i0 = 0; #10;
        t_s = 1; t_i1 = 1; t_i0 = 1; #10;

        $finish;
    end

    // Monitor
    initial begin
        $monitor($time,
                 " I0=%b I1=%b S=%b | Y=%b",
                 t_i0, t_i1, t_s, t_y);
    end

endmodule