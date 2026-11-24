// generate food candidates using a 9 bit linear feedback shift register
// 9 switches choose the seed, 4 bits are needed for x and 5 for y
// the same seed gives the same sequence when enable is used the same way
module lfsr (
    input wire clk,
    input wire reset,
    input wire enable, // try the next number when food placement asks for it
    input wire [8:0] SW, // only read on reset, changing switches during play doesnt change the seed
    output reg [8:0] random_value,
    output wire [3:0] candidate_x,
    output wire [4:0] candidate_y,
    output wire candidate_valid
);
    wire [8:0] candidate_value;

    // the lfsr goes through 1 to 511, subtract 1 so tile (0,0) can be chosen too
    // the only missing combination is (15,31), which is outside the board anyway
    assign candidate_value = random_value - 9'd1;

    // split the same number into x and y instead of using two random generators
    assign candidate_x = candidate_value[3:0];
    assign candidate_y = candidate_value[8:4];

    // check the grid bounds, food placement separately checks if the snake is on this tile
    assign candidate_valid = !reset && (candidate_x < 4'd15) && (candidate_y < 5'd17);

    always @(posedge clk) begin
        // all zero bits would keep shifting back to zero, so use seed 1 for all switches off
        if (reset)
            random_value <= (SW == 9'd0) ? 9'd1 : SW;
            
        // hold the number until another candidate is needed
        // this lets food placement keep a valid tile and skip invalid or occupied ones
        else if (enable)
            // shift left and xor bits 8 and 4 into the new lowest bit
            // these taps give all 511 nonzero states before the sequence repeats
            random_value <= {random_value[7:0], random_value[8] ^ random_value[4]};
    end
endmodule
