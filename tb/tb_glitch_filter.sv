module tb_glitch_filter;

    logic clk;
    logic rst_n;
    logic sig_in;
    logic sig_out;

    glitch_filter #(.STABLE_CYCLES(3)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .sig_in(sig_in),
        .sig_out(sig_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/tb_glitch_filter.vcd");
        $dumpvars(0, tb_glitch_filter);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        sig_in = 0;

        #20 rst_n = 1;

        // glitches (no deben pasar)
        #10 sig_in = 1; #10 sig_in = 0;
        #10 sig_in = 1; #10 sig_in = 0;

        // señal valida
        #10 sig_in = 1;
        #40 sig_in = 0;

        #100 $finish;
    end

endmodule

