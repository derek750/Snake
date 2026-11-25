`timescale 1ns / 1ps

module decimal_display;
    reg clk = 0;
    reg reset, food_eaten;
    wire [7:0] score;
    always #5 clk = ~clk;
    score_counter dut (.clk(clk), .reset(reset), .food_eaten(food_eaten), .score(score));

    wire [3:0] ones = score % 8'd10;
    wire [3:0] tens = (score / 8'd10) % 8'd10;
    wire [3:0] hundreds = score / 8'd100;
    wire [6:0] HEX0, HEX1, HEX2;
    seven_seg_decoder d0 (.digit(ones), .segments(HEX0));
    seven_seg_decoder d1 (.digit(tens), .segments(HEX1));
    seven_seg_decoder d2 (.digit(hundreds), .segments(HEX2));

    initial begin
        reset = 1;
        food_eaten = 0;
        #10 reset = 0;
        food_eaten = 1;
        #2510 food_eaten = 0;
        #20 reset = 1;
        #10 reset = 0;
    end
endmodule
