module tb_top;

    logic clk;
    logic rst_n;
    logic async_in;
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
        .fault_detected(fault_detected)
    );

    // clock 10ns
    always #5 clk = ~clk;

    // VCD
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

    // 🔹 MONITOR GLOBAL
    initial begin
        $display("Tiempo\tasync_in\tfault_detected");
        $monitor("%0t\t%b\t\t%b", $time, async_in, fault_detected);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        async_in = 0;

        #20 rst_n = 1;

        // ===============================
        // CASO 1: Solo glitches
        // ===============================
        $display("\nCASO 1: glitches");

        repeat (4) begin
            #7 async_in = 1;
            #8 async_in = 0;
        end

        #200;
        $display("Resultado: fault_detected = %0b\n", fault_detected);

        // ===============================
        // CASO 2: Eventos validos pero pocos
        // ===============================
        $display("\nCASO 2: pocos eventos");

        repeat (3) begin
            #10 async_in = 1;
            #40 async_in = 0;
        end

        #200;
        $display("Resultado: fault_detected = %0b\n", fault_detected);

        // ===============================
        // CASO 3: Muchos eventos (debe fallar)
        // ===============================
        $display("\nCASO 3: exceso de eventos");

        repeat (8) begin
            #10 async_in = 1;
            #40 async_in = 0;
        end

        #200;
        $display("Resultado: fault_detected = %0b\n", fault_detected);

        // ===============================
        // CASO 4: Reset durante conteo
        // ===============================
        $display("\nCASO 4: reset en medio");

        repeat (4) begin
            #10 async_in = 1;
            #30 async_in = 0;
        end

        #20 rst_n = 0;
        #20 rst_n = 1;

        #200;
        $display("Resultado: fault_detected = %0b\n", fault_detected);

        $finish;
    end

endmodule
