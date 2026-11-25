`timescale 1ns / 1ps

module eating_pulses;
    reg clk = 0;
    reg reset, food_eaten;
    wire [7:0] score;
    always #5 clk = ~clk;
    score_counter dut (.clk(clk), .reset(reset), .food_eaten(food_eaten), .score(score));

    initial begin
        reset = 1;
        food_eaten = 0;
        #10 reset = 0;
        #20 food_eaten = 1;
        #10 food_eaten = 0;
        #20 food_eaten = 1;
        #10 food_eaten = 0;
    end
endmodule
