module top (

    input  logic clk,
    input  logic rst_n,

    input  logic async_in,

    
    // Configuración externa
   

    input  logic [5:0] STABLE_CYCLES,
    input  logic [6:0] WINDOW_SIZE,
    input  logic [6:0] THRESHOLD,

    output logic fault_detected
);

    
    // Señales internas
   

    logic sync_sig;
    logic clean_sig;
    logic event_pulse;

    logic [6:0] event_count;

    
    // Synchronizer
    

    sync_input u_sync (

        .clk(clk),
        .rst_n(rst_n),

        .async_in(async_in),

        .sync_out(sync_sig)

    );


    // Glitch Filter
   

    glitch_filter u_glitch (

        .clk(clk),
        .rst_n(rst_n),

        .sig_in(sync_sig),

        .STABLE_CYCLES(STABLE_CYCLES),

        .sig_out(clean_sig)

    );

    
    // Edge Detector
  

    edge_detector u_edge (

        .clk(clk),
        .rst_n(rst_n),

        .signal_in(clean_sig),

        .pulse_out(event_pulse)

    );

  
    // Sliding Window
    

    sliding_window_counter u_window (

        .clk(clk),
        .rst_n(rst_n),

        .event_pulse(event_pulse),

        .WINDOW_SIZE(WINDOW_SIZE),

        .event_count(event_count)

    );

    
    // FSM
  

    fsm_control u_fsm (

        .clk(clk),
        .rst_n(rst_n),

        .event_count(event_count),

        .THRESHOLD(THRESHOLD),

        .fault_detected(fault_detected)

    );

endmodule
