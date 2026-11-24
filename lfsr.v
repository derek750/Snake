module lfsr (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [8:0] SW,
    output reg [8:0] random_value,
    output wire [3:0] candidate_x,
    output wire [4:0] candidate_y,
    output wire candidate_valid
);
    wire [8:0] candidate_value;

    assign candidate_value = random_value - 9'd1;
    assign candidate_x = candidate_value[3:0];
    assign candidate_y = candidate_value[8:4];
    assign candidate_valid = !reset && (candidate_x < 4'd15) && (candidate_y < 5'd17);

    always @(posedge clk) begin
        if (reset)
            random_value <= (SW == 9'd0) ? 9'd1 : SW;
        else if (enable)
            random_value <= {random_value[7:0], random_value[8] ^ random_value[4]};
    end
endmodule
