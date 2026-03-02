module fsm_control #(
    parameter THRESHOLD = 5
)(
    input  logic clk,
    input  logic rst_n,
    input  logic window_done,
    input  logic [7:0] event_count,
    output logic fault_detected
);

    typedef enum logic {
        MONITOR,
        FAULT
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= MONITOR;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;

        case (state)
            MONITOR:
                if (window_done && event_count > THRESHOLD)
                    next_state = FAULT;

            FAULT:
                next_state = FAULT;
        endcase
    end

    assign fault_detected = (state == FAULT);

endmodule
