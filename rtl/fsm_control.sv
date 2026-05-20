module fsm_control #(
    parameter int MAX_WINDOW_SIZE = 64
)(
    input  logic clk,
    input  logic rst_n,

    input  logic [$clog2(MAX_WINDOW_SIZE+1)-1:0] event_count,

    // CONFIGURABLE INPUT
    input  logic [$clog2(MAX_WINDOW_SIZE+1)-1:0] THRESHOLD,

    output logic fault_detected
);

    typedef enum logic [1:0] {

        MONITOR,
        FAULT

    } state_t;

    state_t state;
    state_t next_state;


    // Registro de estado


    always_ff @(posedge clk or negedge rst_n) begin

        if(!rst_n)
            state <= MONITOR;

        else
            state <= next_state;

    end

   
    // Transiciones


    always_comb begin

        next_state = state;

        case(state)

            MONITOR: begin

                if(event_count >= THRESHOLD)
                    next_state = FAULT;

            end

            FAULT: begin

                next_state = FAULT;

            end

            default: begin

                next_state = MONITOR;

            end

        endcase

    end

    
    // Salidas
   

    always_comb begin

        case(state)

            MONITOR: fault_detected = 1'b0;
            FAULT:   fault_detected = 1'b1;

            default: fault_detected = 1'b0;

        endcase

    end

endmodule
