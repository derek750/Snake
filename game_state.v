module game_state (
    input wire clk,
    input wire reset,
    input wire move_tick,
    input wire collision,
    output wire move_enable,
    output wire game_over
);
    localparam PLAYING = 1'b0, GAME_OVER = 1'b1;
    reg state;

    assign game_over = (state == GAME_OVER);
    assign move_enable = !reset && (state == PLAYING) && move_tick && !collision;

    always @(posedge clk) begin
        if (reset)
            state <= PLAYING;
        else begin
            case (state)
                PLAYING: begin
                    if (move_tick && collision)
                        state <= GAME_OVER;
                end
                GAME_OVER: state <= GAME_OVER;
                default: state <= GAME_OVER;
            endcase
        end
    end
endmodule
