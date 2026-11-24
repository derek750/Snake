`timescale 1ns / 1ps

module body_follows_turns;
    localparam [1:0] D = 2'b00, A = 2'b01, W = 2'b10, S = 2'b11;

    reg clk = 0;
    reg reset;
    reg [1:0] movement_direction;
    reg [7:0] read_index;
    wire [3:0] read_x;
    wire [4:0] read_y;

    always #5 clk = ~clk;

    game #(.CYCLES_PER_MOVE(4)) dut (
        .clk(clk), .reset(reset), .movement_direction(movement_direction),
        .read_index(read_index), .read_x(read_x), .read_y(read_y)
    );

    initial begin
        reset = 1;
        movement_direction = D;
        read_index = 0;
        #10 reset = 0;
        #40 movement_direction = S;
        #40 movement_direction = A;
        #40 read_index = 1;
        #5 read_index = 2;
        #5 read_index = 3;
        #5 read_index = 4;
    end
endmodule
