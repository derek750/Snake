`timescale 1ns / 1ps

module snake_over_food;
    reg clk = 0;
    reg reset, food_ready;
    reg [7:0] length;
    reg [3:0] segment_x, food_x;
    reg [4:0] segment_y, food_y;
    wire [7:0] read_index, vga_x;
    wire [6:0] vga_y;
    wire [8:0] vga_color;
    wire plot;
    always #5 clk = ~clk;
    snake_renderer dut (
        .clk(clk), .reset(reset), .length(length), .read_index(read_index),
        .segment_x(segment_x), .segment_y(segment_y),
        .food_x(food_x), .food_y(food_y), .food_ready(food_ready),
        .vga_x(vga_x), .vga_y(vga_y), .vga_color(vga_color), .plot(plot));

    initial begin
        reset = 1;
        food_ready = 1;
        length = 1;
        segment_x = 0;
        segment_y = 0;
        food_x = 0;
        food_y = 0;
        #10 reset = 0;

    end
endmodule
