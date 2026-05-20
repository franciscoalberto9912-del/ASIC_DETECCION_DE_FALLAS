module sliding_window_counter #(
    parameter int MAX_WINDOW_SIZE = 64
)(
    input  logic clk,
    input  logic rst_n,

    input  logic event_pulse,

    // CONFIGURABLE INPUT
    input  logic [$clog2(MAX_WINDOW_SIZE+1)-1:0] WINDOW_SIZE,

    output logic [$clog2(MAX_WINDOW_SIZE+1)-1:0] event_count
);

    localparam CNT_WIDTH = $clog2(MAX_WINDOW_SIZE+1);

    logic [MAX_WINDOW_SIZE-1:0] window_reg;

    integer i;

    
    // Sliding Window Register
  

    always_ff @(posedge clk or negedge rst_n) begin

        if(!rst_n)
            window_reg <= '0;

        else begin

            window_reg <= {
                window_reg[MAX_WINDOW_SIZE-2:0],
                event_pulse
            };

        end

    end

  

    always_comb begin

        event_count = '0;

        for(i = 0; i < MAX_WINDOW_SIZE; i++) begin

            if(i < WINDOW_SIZE)
                event_count = event_count + window_reg[i];

        end

    end

endmodule
