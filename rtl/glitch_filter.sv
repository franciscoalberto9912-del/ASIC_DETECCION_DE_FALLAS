module glitch_filter #(
    parameter int MAX_STABLE_CYCLES = 32
)(
    input  logic clk,
    input  logic rst_n,

    input  logic sig_in,

    // CONFIGURABLE INPUT
    input  logic [$clog2(MAX_STABLE_CYCLES+1)-1:0] STABLE_CYCLES,

    output logic sig_out
);

    localparam CNT_WIDTH = $clog2(MAX_STABLE_CYCLES+1);

    logic [CNT_WIDTH-1:0] cnt;

    always_ff @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            cnt     <= '0;
            sig_out <= 1'b0;

        end
        else begin

            if(sig_in) begin

                if(cnt < STABLE_CYCLES)
                    cnt <= cnt + 1'b1;

                if(cnt >= STABLE_CYCLES-1)
                    sig_out <= 1'b1;

            end
            else begin

                cnt     <= '0;
                sig_out <= 1'b0;

            end

        end

    end

endmodule
