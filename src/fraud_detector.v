module fraud_detector (
    input  wire ldr_a,
    input  wire ldr_b,
    output wire valid_input,
    output wire fraud_detected
);

    assign fraud_detected = ldr_a & ldr_b;
    assign valid_input = ldr_a ^ ldr_b;

endmodule
