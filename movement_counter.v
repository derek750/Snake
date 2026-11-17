// 50 MHz
module movement_counter #(
    parameter integer CYCLES_PER_MOVE = 10_000_000 // 0.2 seconds
) (
    input wire clk,
    input wire reset, // synchronous, active-high reset
    output wire move_tick
);
    reg [31:0] count;

    assign move_tick = !reset && (count == CYCLES_PER_MOVE - 1);

    always @(posedge clk) begin
        if (reset)
            count <= 32'd0;
        else if (move_tick)
            count <= 32'd0;
        else
            count <= count + 32'd1;
    end
endmodule
