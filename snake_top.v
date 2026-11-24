// connect the keyboard, game, and VGA display on the DE1-SoC
module snake_top (
    input wire CLOCK_50,
    input wire [3:0] KEY,
    input wire PS2_CLK,
    input wire PS2_DAT,
    input wire [8:0] SW,
    output wire [7:0] VGA_R,
    output wire [7:0] VGA_G,
    output wire [7:0] VGA_B,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire VGA_BLANK_N,
    output wire VGA_SYNC_N,
    output wire VGA_CLK
);
    wire reset = !KEY[0];
    wire [1:0] movement_direction;
    wire [1:0] current_direction;
    wire [7:0] length;
    wire [7:0] read_index;
    wire [3:0] read_x;
    wire [4:0] read_y;
    wire [7:0] vga_x;
    wire [6:0] vga_y;
    wire [8:0] vga_color;
    wire plot;

    ps2_keyboard keyboard (
        .clk(CLOCK_50),
        .reset(reset),
        .ps2_clk(PS2_CLK),
        .ps2_dat(PS2_DAT),
        .current_direction(current_direction),
        .movement_direction(movement_direction)
    );

    game snake (
        .clk(CLOCK_50),
        .reset(reset),
        .SW(SW),
        .movement_direction(movement_direction),
        .read_index(read_index),
        .read_x(read_x),
        .read_y(read_y),
        .length(length),
        .current_direction(current_direction)
    );

    snake_renderer renderer (
        .clk(CLOCK_50),
        .reset(reset),
        .length(length),
        .read_index(read_index),
        .segment_x(read_x),
        .segment_y(read_y),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .vga_color(vga_color),
        .plot(plot)
    );

    vga_adapter VGA (
        .resetn(KEY[0]),
        .clock(CLOCK_50),
        .color(vga_color),
        .x(vga_x),
        .y(vga_y),
        .write(plot),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_BLANK_N(VGA_BLANK_N),
        .VGA_SYNC_N(VGA_SYNC_N),
        .VGA_CLK(VGA_CLK)
    );
    defparam VGA.RESOLUTION = "160x120";
    defparam VGA.COLOR_DEPTH = 9;
    defparam VGA.BACKGROUND_IMAGE = "UNUSED";
endmodule
