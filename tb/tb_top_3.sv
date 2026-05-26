`timescale 1ns/1ps

module tb_top;

    logic clk;
    logic rst_n;

    logic async_in;

    
    // Configuración externa
    

    logic [5:0] STABLE_CYCLES;

    logic [6:0] WINDOW_SIZE;
    logic [6:0] THRESHOLD;

    logic fault_detected;

    


    top dut (

        .clk(clk),
        .rst_n(rst_n),

        .async_in(async_in),

        .STABLE_CYCLES(STABLE_CYCLES),
        .WINDOW_SIZE(WINDOW_SIZE),
        .THRESHOLD(THRESHOLD),

        .fault_detected(fault_detected)

    );

    
    // CLOCK 27 MHz
    // T = 37.037 ns
   

    always #18.5185 clk = ~clk;

    
    // VCD
    

    initial begin

        $dumpfile("sim/wave.vcd");
        $dumpvars(0, tb_top);

    end

    
    // TASK DEBUG
    

    task print_debug;

        begin

            $display("\n---------------- DEBUG ----------------");

            $display("TIME             = %0t", $time);

            $display("STABLE_CYCLES    = %0d", STABLE_CYCLES);
            $display("WINDOW_SIZE      = %0d", WINDOW_SIZE);
            $display("THRESHOLD        = %0d", THRESHOLD);

            $display("async_in         = %0b", async_in);

            $display("sync_sig         = %0b", dut.sync_sig);
            $display("clean_sig        = %0b", dut.clean_sig);

            $display("event_pulse      = %0b", dut.event_pulse);

            $display("event_count      = %0d", dut.event_count);

            $display("fault_detected   = %0b", fault_detected);

            $display("FSM state        = %0d", dut.u_fsm.state);

            $display("---------------------------------------\n");

        end

    endtask

    
    // TEST
  

    initial begin

        clk = 0;

        rst_n = 0;

        async_in = 0;

        
        // CONFIGURACIÓN
      

        STABLE_CYCLES = 3;
        WINDOW_SIZE   = 50;
        THRESHOLD     = 5;

       
        $display("CONFIGURACION INICIAL");
        

        $display("CLOCK            = 27 MHz");
        $display("STABLE_CYCLES    = %0d", STABLE_CYCLES);
        $display("WINDOW_SIZE      = %0d", WINDOW_SIZE);
        $display("THRESHOLD        = %0d", THRESHOLD);

        
        // RESET
        

        #100;

        rst_n = 1;

        $display("\nRESET LIBERADO\n");

        
        // CASO 1
        // NO DEBE FALLAR
        

        
        $display("CASO 1 : EVENTOS NORMALES");
        

        repeat(3) begin

            #200 async_in = 1;
            #200 async_in = 0;

        end

        #1000;

        if(fault_detected == 0) begin

            $display("\n[PASS] CASO 1 EXITOSO");
            $display("No se detecto falla como era esperado\n");

        end
        else begin

            $display("\n[FAIL] CASO 1");

            $display("Se detecto una falla cuando NO debia");

            print_debug();

        end

       
        // CASO 2
        // DEBE FALLAR
        

       
        $display("CASO 2 : MUCHOS EVENTOS");
        

        repeat(10) begin

            #150 async_in = 1;
            #150 async_in = 0;

        end

        #1000;

        if(fault_detected == 1) begin

            $display("\n[PASS] CASO 2 EXITOSO");
            $display("La falla fue detectada correctamente\n");

        end
        else begin

            $display("\n[FAIL] CASO 2");

            $display("NO se detecto la falla");

            print_debug();

        end

       
        // CASO 3
        // GLITCHES
       
      
        $display("CASO 3 : GLITCHES");
        

        rst_n = 0;

        #100;

        rst_n = 1;

        repeat(5) begin

            #10 async_in = 1;
            #10 async_in = 0;

        end

        #1000;

        if(fault_detected == 0) begin

            $display("\n[PASS] CASO 3 EXITOSO");
            $display("Los glitches fueron ignorados\n");

        end
        else begin

            $display("\n[FAIL] CASO 3");

            $display("Los glitches activaron fault");

            print_debug();

        end

        
        // CASO 4
        // CAMBIO DINÁMICO
       

        
        $display("CASO 4 : CAMBIO DINAMICO");
        

        rst_n = 0;

        #100;

        rst_n = 1;

        WINDOW_SIZE = 20;
        THRESHOLD   = 3;

        $display("\nNUEVOS PARAMETROS");

        $display("WINDOW_SIZE = %0d", WINDOW_SIZE);
        $display("THRESHOLD   = %0d", THRESHOLD);

        repeat(5) begin

            #150 async_in = 1;
            #150 async_in = 0;

        end

        #1000;

        if(fault_detected == 1) begin

            $display("\n[PASS] CASO 4 EXITOSO");
            $display("La nueva configuracion funciono\n");

        end
        else begin

            $display("\n[FAIL] CASO 4");

            $display("No detecto falla con los nuevos parametros");

            print_debug();

        end

        
        // CASO 5
        // RESET
       

       
        $display("CASO 5 : RESET");
        

        rst_n = 0;

        #100;

        if(fault_detected == 0) begin

            $display("\n[PASS] CASO 5 EXITOSO");
            $display("Reset limpio correctamente el sistema\n");

        end
        else begin

            $display("\n[FAIL] CASO 5");

            $display("Reset NO limpio la falla");

            print_debug();

        end

        
        $display("SIMULACION FINALIZADA");
        

        $finish;

    end

endmodule
