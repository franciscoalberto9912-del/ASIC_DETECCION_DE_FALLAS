module tb_fsm_control;

    logic clk;
    logic rst_n;
    logic start;
    logic window_done;
    logic [7:0] event_count;
    logic window_start;
    logic fault_detected;

    fsm_control dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .window_done(window_done),
        .event_count(event_count),
        .window_start(window_start),
        .fault_detected(fault_detected)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_fsm_control.vcd");
        $dumpvars(0, tb_fsm_control);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        start = 0;
        window_done = 0;
        event_count = 0;

        #20 rst_n = 1;

        #10 start = 1;
        #10 start = 0;

        #40 event_count = 8'd12; // simula falla
        #10 window_done = 1;
        #10 window_done = 0;

        #100 $finish;
    end

endmodule

