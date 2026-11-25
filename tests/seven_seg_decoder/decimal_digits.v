`timescale 1ns / 1ps

module decimal_digits;
    reg [3:0] digit;
    wire [6:0] segments;
    seven_seg_decoder dut (.digit(digit), .segments(segments));

    initial begin
        digit = 0;
        #10 digit = 1;
        #10 digit = 2;
        #10 digit = 3;
        #10 digit = 4;
        #10 digit = 5;
        #10 digit = 6;
        #10 digit = 7;
        #10 digit = 8;
        #10 digit = 9;
        #10 digit = 10;
        #10 digit = 15;
    end
endmodule
