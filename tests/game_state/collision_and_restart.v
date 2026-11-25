`timescale 1ns / 1ps

module collision_and_restart;
    reg clk = 0;
    reg reset, move_tick, collision;
    wire move_enable, game_over;
    always #5 clk = ~clk;
    game_state dut (.clk(clk), .reset(reset), .move_tick(move_tick),
        .collision(collision), .move_enable(move_enable), .game_over(game_over));

    initial begin
        reset = 1;
        move_tick = 0;
        collision = 0;
        #10 reset = 0;
        #10 collision = 1;
        #10 collision = 0;
        move_tick = 1;
        #10 collision = 1;
        #10 collision = 0;
        #20 reset = 1;
        #10 reset = 0;
    end
endmodule
