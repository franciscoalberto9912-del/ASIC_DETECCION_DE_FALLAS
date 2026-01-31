module fsm_control (
    input  logic clk,
    input  logic rst_n,
    input  logic start,
    input  logic window_done,
    input  logic [7:0] event_count,
    output logic window_start,
    output logic fault_detected
);

    typedef enum logic [1:0] {
        IDLE,
        START_WINDOW,
        COUNTING,
        EVALUATE
    } state_t;

    state_t state, next_state;

    // registro de estado
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // lógica de transición
    always_comb begin
        next_state = state;

        case (state)
            IDLE:
                if (start)
                    next_state = START_WINDOW;

            START_WINDOW:
                next_state = COUNTING;

            COUNTING:
                if (window_done)
                    next_state = EVALUATE;

            EVALUATE:
                next_state = IDLE;
        endcase
    end

    // salidas
    always_comb begin
        window_start    = 1'b0;
        fault_detected  = 1'b0;

        case (state)
            START_WINDOW:
                window_start = 1'b1;

            EVALUATE:
                if (event_count > 8'd10)
                    fault_detected = 1'b1;
        endcase
    end

endmodule

