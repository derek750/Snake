`timescale 1ns / 1ps

module candidate_sequence;
    reg clk = 0;
    reg reset;
    reg enable;
    reg [8:0] SW;
    wire [8:0] random_value;
    wire [3:0] candidate_x;
    wire [4:0] candidate_y;
    wire candidate_valid;

    always #5 clk = ~clk;

    lfsr dut (
        .clk(clk), .reset(reset), .enable(enable), .SW(SW),
        .random_value(random_value), .candidate_x(candidate_x),
        .candidate_y(candidate_y), .candidate_valid(candidate_valid)
    );

    initial begin
        reset = 1;
        enable = 0;
        SW = 9'd1;
        #10 reset = 0;
        enable = 1;
    end
endmodule
