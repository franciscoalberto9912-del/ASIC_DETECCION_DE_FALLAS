module edge_detector (
    input  logic clk,
    input  logic rst_n,
    input  logic signal_in,
    output logic pulse_out
);

    logic signal_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            signal_d <= 1'b0;
        end else begin
            signal_d <= signal_in;
        end
    end

    // flanco de subida
    assign pulse_out = signal_in & ~signal_d;

endmodule

