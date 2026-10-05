module voting_fsm (
    input  wire clk,
    input  wire reset,
    input  wire valid_input,
    input  wire fraud_detected,
    output reg vote_enable,
    output reg fraud_alert
);

    localparam IDLE  = 2'b00;
    localparam VOTE  = 2'b01;
    localparam FRAUD = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;

        case (state)

            IDLE: begin
                if (fraud_detected)
                    next_state = FRAUD;
                else if (valid_input)
                    next_state = VOTE;
            end

            VOTE: begin
                next_state = IDLE;
            end

            FRAUD: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end

    always @(*) begin
        vote_enable = 1'b0;
        fraud_alert = 1'b0;

        case (state)

            VOTE: begin
                vote_enable = 1'b1;
            end

            FRAUD: begin
                fraud_alert = 1'b1;
            end

            default: begin
                vote_enable = 1'b0;
                fraud_alert = 1'b0;
            end

        endcase
    end

endmodule
