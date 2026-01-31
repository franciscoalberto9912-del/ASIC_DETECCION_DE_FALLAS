module tb_time_window_counter;

    logic clk;
    logic rst_n;
    logic event_pulse;
    logic window_start;
    logic window_done;
    logic [7:0] event_count;

    time_window_counter #(
        .WINDOW_SIZE(10),
        .CNT_WIDTH(8)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .event_pulse(event_pulse),
        .window_start(window_start),
        .window_done(window_done),
        .event_count(event_count)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_time_window_counter.vcd");
        $dumpvars(0, tb_time_window_counter);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        event_pulse = 0;
        window_start = 0;

        #20 rst_n = 1;

        // abrir ventana
        #10 window_start = 1;
        #10 window_start = 0;

        // eventos dentro de la ventana
        repeat (4) begin
            #10 event_pulse = 1;
            #10 event_pulse = 0;
        end

        #200 $finish;
    end

endmodule

