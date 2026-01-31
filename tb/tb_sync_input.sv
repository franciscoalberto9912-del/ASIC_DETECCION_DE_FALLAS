module tb_sync_input;

    logic clk;
    logic rst_n;
    logic async_in;
    logic sync_out;

    sync_input dut (
        .clk(clk),
        .rst_n(rst_n),
        .async_in(async_in),
        .sync_out(sync_out)
    );

    // Clock 10 ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_sync_input.vcd");
        $dumpvars(0, tb_sync_input);
    end

    initial begin
        clk = 0;
        rst_n = 0;
        async_in = 0;

        #20 rst_n = 1;

        // cambios asincronos
        #13 async_in = 1;
        #17 async_in = 0;
        #9  async_in = 1;

        #100 $finish;
    end

endmodule

