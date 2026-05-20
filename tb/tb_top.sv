`timescale 1ns/1ps

module tb_top;

    logic clk;
    logic rst_n;
    logic async_in;
    logic fault_detected;

    // Parámetros
    localparam STABLE_CYCLES = 3;
    localparam WINDOW_SIZE   = 20;
    localparam CNT_WIDTH     = 8;
    localparam THRESHOLD     = 4;

    // DUT
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

    
    // VCD
    

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

   
    // Monitor de señales
    

    initial begin

        $display("\n==============================================================");
        $display("TIME\tclk\trst\tasync\tsync\tclean\tedge\tcount\tfault\tstate");
        $display("==============================================================");

        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%0d\t%b\t%0d",
            $time,
            clk,
            rst_n,
            async_in,

            // señales internas del DUT
            dut.sync_sig,
            dut.clean_sig,
            dut.event_pulse,
            dut.event_count,
            fault_detected,
            dut.u_fsm.state
        );

    end

    
    // Estímulos
    

    initial begin

        clk = 0;
        rst_n = 0;
        async_in = 0;

        
        // Reset
        

        #30;
        rst_n = 1;

       
        // Caso 1: eventos normales
        

        $display("\nCASO 1: eventos normales");

        repeat (3) begin
            #40 async_in = 1;
            #40 async_in = 0;
        end

        #200;

        
        // Caso 2: muchos eventos
        

        $display("\nCASO 2: falla esperada");

        repeat (10) begin
            #30 async_in = 1;
            #30 async_in = 0;
        end

        #200;

        
        // Caso 3: glitches
        

        $display("\nCASO 3: glitches");

        repeat (5) begin
            #2 async_in = 1;
            #2 async_in = 0;
        end

        #200;

        
        // Caso 4: señal larga
        

        $display("\nCASO 4: señal larga");

        #20 async_in = 1;
        #200 async_in = 0;

        #200;

        
        // Caso 5: reset
        

        $display("\nCASO 5: reset");

        rst_n = 0;
        #20;
        rst_n = 1;

        #200;

        $finish;

    end

endmodule
