`timescale 1ns / 1ps

module direction_changes_between_ticks;
    localparam [1:0] D = 2'b00, A = 2'b01, W = 2'b10, S = 2'b11;
    reg clk = 0;
    reg reset;
    reg [1:0] movement_direction;
    reg [7:0] read_index;
    reg [8:0] SW;
    wire [3:0] read_x, food_x;
    wire [4:0] read_y, food_y;
    wire [7:0] length, score;
    wire game_over, food_ready, food_eaten;
    wire [1:0] current_direction;

    always #5 clk = ~clk;

    game #(.CYCLES_PER_MOVE(4)) dut (
        .clk(clk), .reset(reset), .movement_direction(movement_direction),
        .read_index(read_index), .read_x(read_x), .read_y(read_y),
        .SW(SW), .length(length), .game_over(game_over),
        .current_direction(current_direction),
        .food_x(food_x), .food_y(food_y), .food_ready(food_ready),
        .food_eaten(food_eaten)
    );

    score_counter counter (
        .clk(clk), .reset(reset), .food_eaten(food_eaten), .score(score)
    );

    initial begin
        reset = 1;
        movement_direction = W;
        read_index = 0;
        SW = 9'd1;
        #10 reset = 0;
        #10 movement_direction = D;
        #10 movement_direction = W;
    end
endmodule
