`timescale 1ns / 1ps

module occupied_candidate;
    reg clk = 0;
    reg reset, move_tick, grow;
    reg [3:0] next_head_x, candidate_x;
    reg [4:0] next_head_y, candidate_y;
    reg [7:0] read_index;
    wire read_valid, body_collision, candidate_occupied;
    wire [3:0] read_x, head_x;
    wire [4:0] read_y, head_y;
    wire [7:0] length;
    always #5 clk = ~clk;
    snake_body dut (
        .clk(clk), .reset(reset), .move_tick(move_tick), .grow(grow),
        .next_head_x(next_head_x), .next_head_y(next_head_y),
        .read_index(read_index), .read_valid(read_valid), .read_x(read_x), .read_y(read_y),
        .head_x(head_x), .head_y(head_y), .length(length), .body_collision(body_collision),
        .candidate_x(candidate_x), .candidate_y(candidate_y), .candidate_occupied(candidate_occupied)
    );

    initial begin
        reset = 1;
        move_tick = 0;
        grow = 0;
        next_head_x = 4;
        next_head_y = 8;
        candidate_x = 0;
        candidate_y = 0;
        read_index = 0;
        #10 reset = 0;
        #10 candidate_x = 3;
        candidate_y = 8;
        #10 candidate_x = 2;
        #10 candidate_x = 0;
        #10 candidate_x = 4;
        #10 candidate_x = 0;
        candidate_y = 0;
    end
endmodule
