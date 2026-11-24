module score_counter (
    input wire clk,
    input wire reset,
    input wire food_eaten,
    output reg [7:0] score
);
    always @(posedge clk) begin
        if (reset)
            score <= 8'd0;
        else if (food_eaten && (score < 8'd251))
            score <= score + 8'd1;
    end
endmodule
