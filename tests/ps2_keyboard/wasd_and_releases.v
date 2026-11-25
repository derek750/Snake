`timescale 1ns / 1ps

module wasd_and_releases;
    reg clk = 0;
    reg reset;
    reg ps2_clk, ps2_dat;
    reg [1:0] current_direction;
    wire [1:0] movement_direction;
    always #5 clk = ~clk;
    ps2_keyboard dut (.clk(clk), .reset(reset), .ps2_clk(ps2_clk), .ps2_dat(ps2_dat),
        .current_direction(current_direction), .movement_direction(movement_direction));

    task send_bit;
        input value;
        begin
            ps2_dat = value;
            #100 ps2_clk = 0;
            #100 ps2_clk = 1;
        end
    endtask

    task send_byte;
        input [7:0] value;
        input bad_parity;
        integer bit_index;
        begin
            send_bit(0);
            for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1)
                send_bit(value[bit_index]);
            send_bit((~^value) ^ bad_parity);
            send_bit(1);
            #100;
        end
    endtask

    initial begin
        reset = 1;
        ps2_clk = 1;
        ps2_dat = 1;
        current_direction = 0;
        #100 reset = 0;
        send_byte(8'h1d, 0);
        current_direction = 2;
        send_byte(8'h1c, 0);
        current_direction = 1;
        send_byte(8'h1b, 0);
        current_direction = 3;
        send_byte(8'h23, 0);
        current_direction = 0;
        send_byte(8'hf0, 0);
        send_byte(8'h1d, 0);
        send_byte(8'h21, 0);
    end
endmodule
