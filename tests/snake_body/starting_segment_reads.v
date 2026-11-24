`timescale 1ns / 1ps

module starting_segment_reads;
    reg clk = 0;
    reg reset;
    reg [7:0] read_index;
    reg [3:0] next_head_x;
    reg [4:0] next_head_y;
    wire read_valid;
    wire [3:0] read_x;
    wire [4:0] read_y;
    wire [7:0] length;

    always #5 clk = ~clk;

    snake_body dut (
        .clk(clk), 
        .reset(reset), 
        .move_tick(1'b0), 
        .grow(1'b0),
        .next_head_x(next_head_x), 
        .next_head_y(next_head_y),
        .read_index(read_index), 
        .read_valid(read_valid),
        .read_x(read_x), 
        .read_y(read_y), 
        .length(length)
    );

    initial begin
        reset = 1;
        next_head_x = 8;
        next_head_y = 8;
        read_index = 0;
        #10 reset = 0;
        #10 read_index = 1;
        #10 read_index = 2;
        #10 read_index = 3;
        #10 read_index = 4;
    end
endmodule
