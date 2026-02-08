`timescale 1ns/1ps

module top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        async_in,
    output wire [7:0]  count_out,
    output wire        window_done
);

    // ============================================
    // Señales internas
    // ============================================
    wire sync_sig;
    wire filtered_sig;
    wire edge_pulse;

    // ============================================
    // Instancias
    // ============================================

    sync_input u_sync (
        .clk      (clk),
        .rst_n    (rst_n),
        .async_in (async_in),
        .sync_out (sync_sig)
    );

    glitch_filter u_filter (
        .clk      (clk),
        .rst_n    (rst_n),
        .sig_in   (sync_sig),
        .sig_out  (filtered_sig)
    );

    edge_detector u_edge (
        .clk      (clk),
        .rst_n    (rst_n),
        .signal_in   (filtered_sig),
        .pulse_out(edge_pulse)
    );

    time_window_counter u_window (
        .clk        (clk),
        .rst_n      (rst_n),
        .event_pulse   (edge_pulse),
        .event_count  (count_out),
        .window_done(window_done)
    );

endmodule

