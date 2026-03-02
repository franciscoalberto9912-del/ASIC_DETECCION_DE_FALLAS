module top #(
    parameter int STABLE_CYCLES = 3,
    parameter int WINDOW_SIZE   = 80,
    parameter int CNT_WIDTH     = 8,
    parameter int THRESHOLD     = 3
)(
    input  logic clk,
    input  logic rst_n,
    input  logic async_in,
    output logic fault_detected
);

    logic sync_sig;
    logic clean_sig;
    logic event_pulse;
    logic window_done;
    logic [CNT_WIDTH-1:0] event_count;

    // Sincronizador
    sync_input u_sync (
        .clk(clk),
        .rst_n(rst_n),
        .async_in(async_in),
        .sync_out(sync_sig)
    );

    // Glitch filter
    glitch_filter #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) u_glitch (
        .clk(clk),
        .rst_n(rst_n),
        .sig_in(sync_sig),
        .sig_out(clean_sig)
    );

    // Edge detector
    edge_detector u_edge (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(clean_sig),
        .pulse_out(event_pulse)
    );

    // Ventana + contador eventos
    time_window_counter #(
        .WINDOW_SIZE(WINDOW_SIZE),
        .CNT_WIDTH(CNT_WIDTH)
    ) u_counter (
        .clk(clk),
        .rst_n(rst_n),
        .event_pulse(event_pulse),
        .window_done(window_done),
        .event_count(event_count)
    );

    // FSM continua
    fsm_control #(
        .THRESHOLD(THRESHOLD)
    ) u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .window_done(window_done),
        .event_count(event_count),
        .fault_detected(fault_detected)
    );

endmodule
