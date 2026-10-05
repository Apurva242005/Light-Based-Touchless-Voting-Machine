`timescale 1ns/1ps

module voting_system_tb;

    reg clk;
    reg reset;
    reg ldr_a;
    reg ldr_b;

    wire [7:0] vote_count;
    wire [6:0] segments;
    wire green_led;
    wire red_led;
    wire buzzer;
    wire gated_clk;

    top_module uut (
        .clk(clk),
        .reset(reset),
        .ldr_a(ldr_a),
        .ldr_b(ldr_b),
        .vote_count(vote_count),
        .segments(segments),
        .green_led(green_led),
        .red_led(red_led),
        .buzzer(buzzer),
        .gated_clk(gated_clk)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        ldr_a = 1'b0;
        ldr_b = 1'b0;

        #20;
        reset = 1'b0;

        #20;
        ldr_a = 1'b1;
        ldr_b = 1'b0;

        #10;
        ldr_a = 1'b0;
        ldr_b = 1'b0;

        #20;
        ldr_a = 1'b0;
        ldr_b = 1'b1;

        #10;
        ldr_a = 1'b0;
        ldr_b = 1'b0;

        #20;
        ldr_a = 1'b1;
        ldr_b = 1'b1;

        #10;
        ldr_a = 1'b0;
        ldr_b = 1'b0;

        #20;
        ldr_a = 1'b1;
        ldr_b = 1'b0;

        #10;
        ldr_a = 1'b0;
        ldr_b = 1'b0;

        #30;
        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | Reset=%b | LDR_A=%b | LDR_B=%b | Vote_Count=%d | Green=%b | Red=%b | Buzzer=%b | Gated_Clock=%b",
            $time,
            reset,
            ldr_a,
            ldr_b,
            vote_count,
            green_led,
            red_led,
            buzzer,
            gated_clk
        );
    end

endmodule
