module tb_top;

    logic clk;
    logic rst_n;
    logic async_in;
    logic start;
    logic fault_detected;

    // instancia DUT
    top #(
        .STABLE_CYCLES(3),
        .WINDOW_SIZE(20),
        .CNT_WIDTH(8),
        .THRESHOLD(5)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .async_in(async_in),
        .start(start),
        .fault_detected(fault_detected)
    );

    // clock 10ns
    always #5 clk = ~clk;

    // VCD
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        async_in = 0;
        start = 0;

        #20 rst_n = 1;

        // ===============================
        // CASO 1: Solo glitches
        // ===============================
        $display("CASO 1: glitches");

        #10 start = 1; #10 start = 0;

        repeat (4) begin
            #7 async_in = 1;
            #8 async_in = 0;
        end

        #200;

        // ===============================
        // CASO 2: Eventos validos pero pocos
        // ===============================
        $display("CASO 2: pocos eventos");

        #10 start = 1; #10 start = 0;

        repeat (3) begin
            #10 async_in = 1;
            #40 async_in = 0;
        end

        #200;

        // ===============================
        // CASO 3: Muchos eventos (debe fallar)
        // ===============================
        $display("CASO 3: exceso de eventos");

        #10 start = 1; #10 start = 0;

        repeat (8) begin
            #10 async_in = 1;
            #40 async_in = 0;
        end

        #200;

        // ===============================
        // CASO 4: Reset durante conteo
        // ===============================
        $display("CASO 4: reset en medio");

        #10 start = 1; #10 start = 0;

        repeat (4) begin
            #10 async_in = 1;
            #30 async_in = 0;
        end

        #20 rst_n = 0;
        #20 rst_n = 1;

        #200;

        $finish;
    end

endmodule
