`timescale 1ns / 1ps

module seed_loading;
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
        SW = 9'd0;
        #10 reset = 0;
        #10 SW = 9'd123;
        #20 reset = 1;
        #10 reset = 0;
        #10 enable = 1;
        #30 enable = 0;
    end
endmodule
