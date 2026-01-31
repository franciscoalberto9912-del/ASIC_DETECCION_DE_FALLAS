module tb_edge_detector;

    logic clk;
    logic rst_n;
    logic signal_in;
    logic pulse_out;

    edge_detector dut (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(signal_in),
        .pulse_out(pulse_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_edge_detector.vcd");
        $dumpvars(0, tb_edge_detector);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        signal_in = 0;

        #20 rst_n = 1;

        #20 signal_in = 1;
        #40 signal_in = 0;
        #20 signal_in = 1;

        #100 $finish;
    end

endmodule

