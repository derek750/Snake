// read W A S D from the PS2 keyboard
module ps2_keyboard (
    input wire clk,
    input wire reset,
    input wire ps2_clk,
    input wire ps2_dat,
    input wire [1:0] current_direction, // direction of the last actual move
    output reg [1:0] movement_direction
);
    localparam [1:0] D = 2'b00, A = 2'b01, W = 2'b10, S = 2'b11;

    // sync the keyboard clock and data to the 50 MHz clock
    reg clk_meta, clk_sync, clk_previous;
    reg dat_meta, dat_sync;

    // one keyboard byte has a start bit, 8 data bits, parity, and a stop bit
    reg [3:0] bit_count;
    reg [7:0] data_byte;
    reg parity_bit;
    reg start_ok;
    reg break_pending; // F0 means the next key is being released
    reg extended_pending;
    reg [1:0] decoded_direction;
    reg decoded_valid;

    // keyboard data is read when its clock goes from 1 to 0
    wire falling_ps2_clock = clk_previous && !clk_sync;

    // convert the key's scan code to the direction codes used in game.v
    always @(*) begin
        decoded_direction = movement_direction;
        decoded_valid = 1'b1;
        case (data_byte)
            8'h23: decoded_direction = D;
            8'h1c: decoded_direction = A;
            8'h1d: decoded_direction = W;
            8'h1b: decoded_direction = S;
            default: decoded_valid = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            clk_meta <= 1'b1;
            clk_sync <= 1'b1;
            clk_previous <= 1'b1;
            dat_meta <= 1'b1;
            dat_sync <= 1'b1;
            bit_count <= 4'd0;
            data_byte <= 8'd0;
            parity_bit <= 1'b0;
            start_ok <= 1'b0;
            break_pending <= 1'b0;
            extended_pending <= 1'b0;
            movement_direction <= D;
        end else begin
            clk_meta <= ps2_clk;
            clk_sync <= clk_meta;
            clk_previous <= clk_sync;
            dat_meta <= ps2_dat;
            dat_sync <= dat_meta;

            // collect one bit on each falling edge of the keyboard clock
            if (falling_ps2_clock) begin
                case (bit_count)
                    4'd0: begin
                        // start bit should be 0
                        start_ok <= !dat_sync;
                        bit_count <= 4'd1;
                    end
                    4'd1, 4'd2, 4'd3, 4'd4,
                    4'd5, 4'd6, 4'd7, 4'd8: begin
                        data_byte[bit_count - 4'd1] <= dat_sync;
                        bit_count <= bit_count + 4'd1;
                    end
                    4'd9: begin
                        parity_bit <= dat_sync;
                        bit_count <= 4'd10;
                    end
                    4'd10: begin
                        bit_count <= 4'd0;
                        // only use the byte if the start, parity, and stop bits are correct
                        if (start_ok && dat_sync && ((^data_byte) ^ parity_bit)) begin
                            if (data_byte == 8'hf0)
                                break_pending <= 1'b1;
                            else if (data_byte == 8'he0)
                                extended_pending <= 1'b1;
                            else begin
                                // ignore releases, other keys, and a turn back into the body
                                if (!break_pending && !extended_pending && decoded_valid &&
                                    (decoded_direction != (current_direction ^ 2'b01)))
                                    movement_direction <= decoded_direction;
                                break_pending <= 1'b0;
                                extended_pending <= 1'b0;
                            end
                        end
                    end
                    default: bit_count <= 4'd0;
                endcase
            end
        end
    end
endmodule
