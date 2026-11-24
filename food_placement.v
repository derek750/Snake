module food_placement (
    input wire clk,
    input wire reset,
    input wire [8:0] SW,
    input wire new_food,
    input wire candidate_occupied,
    output wire [3:0] candidate_x,
    output wire [4:0] candidate_y,
    output reg [3:0] food_x,
    output reg [4:0] food_y,
    output reg food_ready
);
    wire candidate_valid;
    wire searching;

    assign searching = !food_ready && !new_food;

    lfsr random_generator (
        .clk(clk), .reset(reset), .SW(SW),
        .enable(new_food || (searching && (!candidate_valid || candidate_occupied))),
        .candidate_x(candidate_x), .candidate_y(candidate_y),
        .candidate_valid(candidate_valid)
    );

    always @(posedge clk) begin
        if (reset) begin
            food_x <= 4'd0;
            food_y <= 5'd0;
            food_ready <= 1'b0;
        end else if (new_food)
            food_ready <= 1'b0;
        else if (searching && candidate_valid && !candidate_occupied) begin
            food_x <= candidate_x;
            food_y <= candidate_y;
            food_ready <= 1'b1;
        end
    end
endmodule
