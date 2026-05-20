module sync_input (
    input  logic clk,
    input  logic rst_n,
    input  logic async_in,

    output logic sync_out
);

    logic meta;

    always_ff @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin
            meta     <= 1'b0;
            sync_out <= 1'b0;
        end
        else begin
            meta     <= async_in;
            sync_out <= meta;
        end

    end

endmodule
