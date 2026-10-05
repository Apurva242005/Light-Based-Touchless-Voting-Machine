module vote_counter (
    input  wire clk,
    input  wire reset,
    input  wire vote_enable,
    output reg [7:0] vote_count
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            vote_count <= 8'd0;
        else if (vote_enable)
            vote_count <= vote_count + 8'd1;
    end

endmodule
