module alert_controller (
    input  wire valid_vote,
    input  wire fraud_alert,
    output reg green_led,
    output reg red_led,
    output reg buzzer
);

    always @(*) begin
        green_led = 1'b0;
        red_led = 1'b0;
        buzzer = 1'b0;

        if (fraud_alert) begin
            red_led = 1'b1;
            buzzer = 1'b1;
        end
        else if (valid_vote) begin
            green_led = 1'b1;
        end
    end

endmodule
