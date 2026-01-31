module glitch_filter #(
    parameter int STABLE_CYCLES = 3
)(
    input  logic clk,
    input  logic rst_n,
    input  logic sig_in,     // señal ya sincronizada
    output logic sig_out     // señal limpia
);

    logic [$clog2(STABLE_CYCLES+1)-1:0] cnt;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt     <= '0;
            sig_out <= 1'b0;
        end else begin
            if (sig_in) begin
                if (cnt < STABLE_CYCLES)
                    cnt <= cnt + 1'b1;
            end else begin
                cnt <= '0;
            end

            if (cnt >= STABLE_CYCLES-1)
                sig_out <= 1'b1;
            else
                sig_out <= 1'b0;
        end
    end

endmodule

