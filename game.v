module game #(
    parameter integer CYCLES_PER_MOVE = 10_000_000
) (
    input wire clk,
    input wire reset,
    input wire [1:0] movement_direction,
    input wire [7:0] read_index,
    output wire [3:0] read_x,
    output wire [4:0] read_y,
    output wire [7:0] length,
    output reg [1:0] current_direction,
    output wire game_over,
    input wire [8:0] SW,
    output wire [3:0] food_x,
    output wire [4:0] food_y,
    output wire food_ready,
    output wire food_eaten
);
    localparam [1:0] D = 2'b00, A = 2'b01, W = 2'b10, S = 2'b11;

    wire move_tick;
    wire move_enable;
    wire wall_collision;
    wire body_collision;
    wire [3:0] candidate_x;
    wire [4:0] candidate_y;
    wire candidate_occupied;
    wire food_ahead;
    wire [3:0] head_x;
    wire [4:0] head_y;
    reg [3:0] next_head_x;
    reg [4:0] next_head_y;

    // check if food is about to be eaten
    assign food_ahead = food_ready && (next_head_x == food_x) && (next_head_y == food_y);
    assign food_eaten = move_enable && food_ahead;

    always @(posedge clk) begin
        if (reset)
            current_direction <= D;
        else if (move_enable)
            current_direction <= movement_direction;
    end

    assign wall_collision = 
        ((movement_direction == D) && (head_x == 4'd14)) ||
        ((movement_direction == A) && (head_x == 4'd0)) ||
        ((movement_direction == W) && (head_y == 5'd0)) ||
        ((movement_direction == S) && (head_y == 5'd16));

    game_state controller (
        .clk(clk),
        .reset(reset),
        .move_tick(move_tick),
        .collision(wall_collision || body_collision),
        .move_enable(move_enable),
        .game_over(game_over)
    );

    // moving logic
    always @(*) begin
        // head isnt updated in game logic, snake_body updates it, therefore it can be changed until tick
        next_head_x = head_x;
        next_head_y = head_y;
        case (movement_direction)
        // no bounds check
            D: next_head_x = head_x + 4'd1;
            A: next_head_x = head_x - 4'd1;
            W: next_head_y = head_y - 5'd1;
            S: next_head_y = head_y + 5'd1;
        endcase
    end

    movement_counter #(.CYCLES_PER_MOVE(CYCLES_PER_MOVE)) timer (
        .clk(clk), .reset(reset), .move_tick(move_tick)
    );

    food_placement food (
        .clk(clk), .reset(reset), .SW(SW), .new_food(food_eaten),
        .candidate_occupied(candidate_occupied),
        .candidate_x(candidate_x), .candidate_y(candidate_y),
        .food_x(food_x), .food_y(food_y), .food_ready(food_ready)
    );

    snake_body snake (
        .clk(clk), 
        .reset(reset), 
        .move_tick(move_enable), 
        .grow(food_ahead),
        .next_head_x(next_head_x),
        .next_head_y(next_head_y),
        .read_index(read_index),
        .read_x(read_x),
        .read_y(read_y),
        .head_x(head_x),
        .head_y(head_y),
        .length(length),
        .body_collision(body_collision),
        .candidate_x(candidate_x),
        .candidate_y(candidate_y),
        .candidate_occupied(candidate_occupied)
    );
endmodule
