`timescale 1ns/1ps

module tb_top;

  // =====================================================
  // 1️⃣ Señales del testbench
  // =====================================================
  logic clk;
  logic rst_n;
  logic async_in;

  logic [7:0] count_out;
  logic       window_done;

  // =====================================================
  // 2️⃣ Instancia del DUT
  // =====================================================
  top dut (
    .clk         (clk),
    .rst_n       (rst_n),
    .async_in    (async_in),
    .count_out   (count_out),
    .window_done (window_done)
  );

  // =====================================================
  // 3️⃣ Reloj (100 MHz)
  // =====================================================
  initial clk = 0;
  always #5 clk = ~clk;

  // =====================================================
  // 4️⃣ Reset
  // =====================================================
  initial begin
    rst_n    = 0;
    async_in = 0;
    #50;
    rst_n    = 1;
  end

  // =====================================================
  // 5️⃣ DUMP PARA GTKWave  🔥 (ESTO FALTABA)
  // =====================================================
  initial begin
    $dumpfile("waves.vcd");   // archivo de ondas
    $dumpvars(0, tb_top);     // todo el TB y lo que cuelga de él
  end

  // =====================================================
  // 6️⃣ Monitor por consola
  // =====================================================
  initial begin
    $display("Time(ns)  async  count  window_done");
    $monitor("%8t    %b      %0d        %b",
              $time, async_in, count_out, window_done);
  end

  // =====================================================
  // 7️⃣ ESCENARIO 1: GLITCH (NO debe contar)
  // =====================================================
  initial begin
    #100;
    $display("\n--- ESCENARIO 1: GLITCH ---");
    async_in = 1;
    #7;
    async_in = 0;
  end

  // =====================================================
  // 8️⃣ ESCENARIO 2: REBOTE
  // =====================================================
  initial begin
    #300;
    $display("\n--- ESCENARIO 2: REBOTE ---");

    async_in = 1; #10;
    async_in = 0; #8;
    async_in = 1; #12;
    async_in = 0;

    #100;
    async_in = 1;
    #200;
    async_in = 0;
  end

  // =====================================================
  // 9️⃣ ESCENARIO 3: EVENTOS VÁLIDOS
  // =====================================================
  initial begin
    #700;
    $display("\n--- ESCENARIO 3: EVENTOS VALIDOS ---");

    repeat (5) begin
      async_in = 1;
      #80;
      async_in = 0;
      #120;
    end
  end

  // =====================================================
  // 🔚 FIN DE SIMULACIÓN
  // =====================================================
  initial begin
    #2000;
    $display("\n--- FIN DE SIMULACION ---");
    $finish;
  end

endmodule

