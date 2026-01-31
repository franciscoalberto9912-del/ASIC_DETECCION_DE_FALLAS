module time_window_counter #(
    parameter int WINDOW_SIZE = 1000,
    parameter int CNT_WIDTH   = 8
)(
    input  logic clk,
    input  logic rst_n,
    input  logic event_pulse,
    input  logic window_start,
    output logic window_done,
    output logic [CNT_WIDTH-1:0] event_count
);

    logic [$clog2(WINDOW_SIZE)-1:0] window_cnt;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            window_cnt  <= '0;
            event_count <= '0;
            window_done <= 1'b0;
        end else if (window_start) begin
            window_cnt  <= '0;
            event_count <= '0;
            window_done <= 1'b0;
        end else begin
            window_cnt <= window_cnt + 1'b1;

            if (event_pulse)
                event_count <= event_count + 1'b1;

            if (window_cnt == WINDOW_SIZE-1)
                window_done <= 1'b1;
        end
    end

endmodule

