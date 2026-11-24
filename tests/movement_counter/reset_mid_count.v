`timescale 1ns / 1ps

module reset_mid_count;
    reg clk = 0;
    reg reset;
    wire move_tick;

    always #5 clk = ~clk;

    movement_counter #(.CYCLES_PER_MOVE(4)) dut (
        .clk(clk), .reset(reset), .move_tick(move_tick)
    );

    initial begin
        reset = 1;
        #10 reset = 0;
        #60 reset = 1;
        #10 reset = 0;
    end
endmodule
