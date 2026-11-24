// position storage for a snake on a 15-column by 17-row grid.
// index 0 is the head, index length-1 is the tail
module snake_body (
    input wire clk,
    // synchronus active high reset
    input wire reset,
    // one clock-cycle enable per movement
    input wire move_tick,      
    input wire [3:0] next_head_x,
    input wire [4:0] next_head_y,
    input wire grow,

    input wire [7:0] read_index,
    output wire read_valid,
    output wire [3:0] read_x,
    output wire [4:0] read_y,
    output wire [3:0] head_x,
    output wire [4:0] head_y,
    output reg [7:0] length,
    output reg body_collision
);
    // 15 x 17 
    localparam MAX_LENGTH = 255;
    reg [3:0] body_x [0:MAX_LENGTH-1];
    reg [4:0] body_y [0:MAX_LENGTH-1];
    integer i;
    integer segment;

    assign head_x = body_x[0];
    assign head_y = body_y[0];

    // allow reading of a snake part position
    assign read_valid = (read_index < length);
    assign read_x = read_valid ? body_x[read_index] : 4'dx;
    assign read_y = read_valid ? body_y[read_index] : 5'dx;

    // check body collision
    always @(*) begin
        body_collision = 1'b0;
        for (segment = 1; segment < MAX_LENGTH; segment = segment + 1) begin
            if ((segment < length) &&
                (grow || (segment < length - 8'd1)) &&
                (next_head_x == body_x[segment]) &&
                (next_head_y == body_y[segment]))
                body_collision = 1'b1;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            length <= 8'd4; // default 4 length
            // initial snake faces right: head (7,8), tail (4,8).
            body_x[0] <= 4'd3;
            body_x[1] <= 4'd2;
            body_x[2] <= 4'd1;
            body_x[3] <= 4'd0;
            for (i = 0; i < MAX_LENGTH; i = i + 1)
                body_y[i] <= 5'd8;
            for (i = 4; i < MAX_LENGTH; i = i + 1)
                body_x[i] <= 4'd0;
        end else if (move_tick) begin
            // idea is to copy the body part infront of you
            for (i = 1; i < MAX_LENGTH; i = i + 1) begin
                if ((i < length) || (grow && (i == length))) begin
                    body_x[i] <= body_x[i-1];
                    body_y[i] <= body_y[i-1];
                end
            end
            body_x[0] <= next_head_x;
            body_y[0] <= next_head_y;
            if (grow && (length < MAX_LENGTH))
                length <= length + 8'd1;
        end
    end
endmodule
