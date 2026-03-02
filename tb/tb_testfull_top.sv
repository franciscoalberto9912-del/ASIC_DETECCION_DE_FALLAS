`timescale 1ns/1ps

module tb_testfull_top;

    logic clk;
    logic rst_n;
    logic async_in;
    logic fault_detected;

    // Parámetros iguales al DUT
    localparam STABLE_CYCLES = 3;
    localparam WINDOW_SIZE   = 20;
    localparam CNT_WIDTH     = 8;
    localparam THRESHOLD     = 5;

    top #(
        .STABLE_CYCLES(STABLE_CYCLES),
        .WINDOW_SIZE(WINDOW_SIZE),
        .CNT_WIDTH(CNT_WIDTH),
        .THRESHOLD(THRESHOLD)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .async_in(async_in),
        .fault_detected(fault_detected)
    );

    // Clock 10ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("test_full.vcd");
        $dumpvars(0, tb_testfull_top);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        async_in = 0;

        // Reset
        #30;
        rst_n = 1;

        // ====================================
        // CASO 1: Normal (no debe fallar)
        // ====================================
        repeat (6) begin
            #40 async_in = 1;
            #40 async_in = 0;
        end

        #500;

        // ====================================
        // CASO 2: Falla (muchos eventos rápidos)
        // Debe activar fault_detected
        // ====================================
        repeat (10) begin
            #10 async_in = 1;
            #10 async_in = 0;
        end

        #500;

        // ====================================
        // CASO 3: Glitches (no deben contar)
        // ====================================
        repeat (5) begin
            #3 async_in = 1;   // demasiado corto
            #3 async_in = 0;
        end

        #500;

        // ====================================
        // CASO 4: Reset limpia la falla
        // ====================================
        rst_n = 0;
        #20;
        rst_n = 1;

        #200;

        $finish;
    end

endmodule
