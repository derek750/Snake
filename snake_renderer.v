// draw the snake on a 15 x 17 grid
// use the course VGA adapter at 160 x 120 with 9-bit color
module snake_renderer (
    input wire clk,
    input wire reset,
    input wire [7:0] length,
    output reg [7:0] read_index,
    input wire [3:0] segment_x,
    input wire [4:0] segment_y,
    output wire [7:0] vga_x,
    output wire [6:0] vga_y,
    output wire [8:0] vga_color,
    output wire plot
);
    // first find what is in a cell, then draw its 7 x 7 pixels
    localparam LOOKUP = 1'b0, PAINT = 1'b1;
    localparam [8:0] LIGHT_GREEN = 9'h038;
    localparam [8:0] DARK_GREEN = 9'h028;
    localparam [8:0] HEAD_COLOR = 9'h007;
    localparam [8:0] BODY_COLOR = 9'h1c0;

    reg state;
    // which grid cell and which pixel inside that cell we are drawing
    reg [3:0] cell_x;
    reg [4:0] cell_y;
    reg [2:0] pixel_x;
    reg [2:0] pixel_y;
    reg [8:0] cell_color;

    // plot tells the VGA adapter to write the pixel at vga_x and vga_y
    assign plot = !reset && (state == PAINT);
    // center the 105-pixel-wide grid by starting it at x = 27
    assign vga_x = 8'd27 + cell_x * 8'd7 + pixel_x;
    assign vga_y = cell_y * 7'd7 + pixel_y;
    assign vga_color = cell_color;

    always @(posedge clk) begin
        if (reset) begin
            // start again at the top-left grid cell
            state <= LOOKUP;
            cell_x <= 4'd0;
            cell_y <= 5'd0;
            pixel_x <= 3'd0;
            pixel_y <= 3'd0;
            read_index <= 8'd0;
            cell_color <= LIGHT_GREEN;
        end else if (state == LOOKUP) begin
            // read snake parts one at a time to see if one is in this cell
            if (read_index >= length) begin
                // alternate green shades between neighboring empty cells
                cell_color <= (cell_x[0] ^ cell_y[0]) ? DARK_GREEN : LIGHT_GREEN;
                pixel_x <= 3'd0;
                pixel_y <= 3'd0;
                state <= PAINT;
            end else if (segment_x == cell_x && segment_y == cell_y) begin
                // index 0 is the head; all other parts use the body color
                cell_color <= (read_index == 8'd0) ? HEAD_COLOR : BODY_COLOR;
                pixel_x <= 3'd0;
                pixel_y <= 3'd0;
                state <= PAINT;
            end else begin
                read_index <= read_index + 8'd1;
            end
        end else if (pixel_x == 3'd6) begin
            // after the last pixel in a row, move down one pixel row
            pixel_x <= 3'd0;
            if (pixel_y == 3'd6) begin
                // after all 49 pixels, move to the next grid cell
                pixel_y <= 3'd0;
                read_index <= 8'd0;
                state <= LOOKUP;
                if (cell_x == 4'd14) begin
                    // end of the grid row; wrap to the next row or start again
                    cell_x <= 4'd0;
                    cell_y <= (cell_y == 5'd16) ? 5'd0 : cell_y + 5'd1;
                end else begin
                    cell_x <= cell_x + 4'd1;
                end
            end else begin
                pixel_y <= pixel_y + 3'd1;
            end
        end else begin
            // draw the next pixel in the same row
            pixel_x <= pixel_x + 3'd1;
        end
    end
endmodule
