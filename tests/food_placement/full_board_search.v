`timescale 1ns / 1ps

module full_board_search;
    reg clk = 0;
    reg reset, new_food;
    reg [8:0] SW;
    reg [7:0] length;
    wire [3:0] candidate_x, food_x;
    wire [4:0] candidate_y, food_y;
    wire candidate_occupied, food_ready;
    always #5 clk = ~clk;
    assign candidate_occupied = (length == 8'd255) ||
        ((candidate_y == 5'd8) && (candidate_x <= 4'd3));
    food_placement dut (
        .clk(clk), .reset(reset), .SW(SW), .new_food(new_food),
        .candidate_occupied(candidate_occupied), .candidate_x(candidate_x), .candidate_y(candidate_y),
        .food_x(food_x), .food_y(food_y), .food_ready(food_ready)
    );

    initial begin
        reset = 1;
        new_food = 0;
        length = 8'd255;
        SW = 9'd1;
        #10 reset = 0;

    end
endmodule
