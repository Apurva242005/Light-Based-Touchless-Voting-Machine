module top_module (
    input  wire clk,
    input  wire reset,
    input  wire ldr_a,
    input  wire ldr_b,
    output wire [7:0] vote_count,
    output wire [6:0] segments,
    output wire green_led,
    output wire red_led,
    output wire buzzer,
    output wire gated_clk
);

    wire valid_input;
    wire fraud_detected;
    wire vote_enable;
    wire fraud_alert;
    wire system_active;

    assign system_active = ldr_a | ldr_b;

    fraud_detector u_fraud_detector (
        .ldr_a(ldr_a),
        .ldr_b(ldr_b),
        .valid_input(valid_input),
        .fraud_detected(fraud_detected)
    );

    voting_fsm u_voting_fsm (
        .clk(clk),
        .reset(reset),
        .valid_input(valid_input),
        .fraud_detected(fraud_detected),
        .vote_enable(vote_enable),
        .fraud_alert(fraud_alert)
    );

    vote_counter u_vote_counter (
        .clk(clk),
        .reset(reset),
        .vote_enable(vote_enable),
        .vote_count(vote_count)
    );

    seven_segment u_seven_segment (
        .vote_count(vote_count),
        .segments(segments)
    );

    alert_controller u_alert_controller (
        .valid_vote(vote_enable),
        .fraud_alert(fraud_alert),
        .green_led(green_led),
        .red_led(red_led),
        .buzzer(buzzer)
    );

    clock_gating u_clock_gating (
        .clk(clk),
        .enable(system_active),
        .gated_clk(gated_clk)
    );

endmodule
