`timescale 1ns / 1ps

module body_follows_head;
    reg clk = 0;
    reg reset, move_tick;
    reg [3:0] next_head_x;
    reg [4:0] next_head_y;
    reg [7:0] read_index;
    wire [3:0] head_x, read_x;
    wire [4:0] head_y, read_y;

    always #5 clk = ~clk;

    snake_body dut (
        .clk(clk), 
        .reset(reset), 
        .move_tick(move_tick), 
        .grow(1'b0),
        .next_head_x(next_head_x), 
        .next_head_y(next_head_y),
        .head_x(head_x), 
        .head_y(head_y),
        .read_index(read_index), 
        .read_x(read_x), 
        .read_y(read_y)
    );

    initial begin
        reset = 1;
        move_tick = 0;
        next_head_x = 8;
        next_head_y = 8;
        read_index = 1;
        #10 reset = 0;
        #10 move_tick = 1;
        #10 move_tick = 0;
        next_head_y = 7;
        #10 move_tick = 1;
        #10 move_tick = 0;
        #10 read_index = 2;
        #10 read_index = 3;
    end
endmodule
