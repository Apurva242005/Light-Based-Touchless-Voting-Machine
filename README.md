# Light-Based Touchless Voting Machine with Dual-LDR Fraud Detection & Smart Idle Power Saver

## Project Overview

The Light-Based Touchless Voting Machine is an FPGA-based digital voting system designed to provide touchless voting using light-based sensing. The system uses two LDR sensors to detect voter interaction and identify invalid or fraudulent sensor activation.

The complete system is designed using Verilog HDL and can be implemented on an FPGA development board.

## Objectives

* Design a touchless voting mechanism using LDR sensors.
* Use dual-LDR sensing for fraud or invalid-input detection.
* Implement the voting sequence using a finite state machine.
* Count valid votes using a digital vote counter.
* Display the vote count using a seven-segment display.
* Provide separate valid and fraud alerts.
* Reduce unnecessary switching activity during system idle periods using clock gating.

## System Architecture

```text
             LDR Sensor A
                  │
                  ├──────────────┐
                  │              │
                  ▼              ▼
             Input Logic    Fraud Detector
                  │              │
                  └──────┬───────┘
                         │
                         ▼
                  Voting FSM
                         │
                         ▼
                   Vote Counter
                         │
                         ▼
                Seven-Segment Display

       Valid Vote ──► Alert Controller ──► Green LED

       Fraud/Invalid ─► Alert Controller
                              │
                              ├──► Red LED
                              └──► Buzzer

                    Clock Gating
                         │
                         ▼
                  Idle Power Saving
```

## Main Modules

| Module               | Description                                   |
| -------------------- | --------------------------------------------- |
| `top_module.v`       | Integrates all system modules                 |
| `voting_fsm.v`       | Controls the voting sequence using an FSM     |
| `vote_counter.v`     | Counts valid votes                            |
| `fraud_detector.v`   | Detects invalid dual-LDR activation           |
| `seven_segment.v`    | Drives the seven-segment display              |
| `alert_controller.v` | Controls valid and fraud indications          |
| `clock_gating.v`     | Controls clock activity during idle operation |

## Input and Output

### Inputs

* LDR Sensor A
* LDR Sensor B
* System clock
* Reset

### Outputs

* Seven-segment display
* Valid vote indication
* Fraud/invalid indication
* Buzzer control

## Voting Concept

The two LDR sensors provide light-based touchless input.

A valid sensor sequence is processed by the voting FSM. When the input satisfies the required voting conditions, the vote counter is incremented.

If an invalid or fraudulent sensor activation is detected, the vote is not counted and the alert controller activates the fraud indication.

## Simulation

The design is verified using a Verilog testbench.

The testbench checks:

* System reset
* Valid voting operation
* Vote counting
* Dual-LDR invalid/fraud condition
* Alert generation
* Seven-segment output
* System idle behavior

Simulation results are documented in:

```text
simulation/simulation_results.md
```

## Project Structure

```text
Light-Based-Touchless-Voting-Machine/
│
├── README.md
│
├── src/
│   ├── top_module.v
│   ├── voting_fsm.v
│   ├── vote_counter.v
│   ├── fraud_detector.v
│   ├── seven_segment.v
│   ├── alert_controller.v
│   └── clock_gating.v
│
├── testbench/
│   └── voting_system_tb.v
│
├── simulation/
│   └── simulation_results.md
│
├── constraints/
│   └── pin_constraints.xdc
│
└── docs/
    ├── block_diagram.png
    ├── fsm_diagram.png
    └── circuit_diagram.png
```

## Technologies Used

* Verilog HDL
* FPGA
* Digital Logic Design
* Finite State Machine
* LDR-based sensing
* Seven-Segment Display
* Clock Gating
* Icarus Verilog / EDA Playground
* Xilinx Vivado

## Applications

The proposed system can be used as an academic demonstration of:

* Touchless digital input
* FPGA-based voting logic
* Sensor-based fraud detection
* Finite state machine design
* Digital vote counting
* Low-power digital design

## Future Scope

The system can be extended by adding:

* Multiple candidate selection
* Secure voter authentication
* Non-volatile vote storage
* Advanced anti-tampering mechanisms
* FPGA board-based hardware implementation
* Remote monitoring and vote-result logging

## Author

Third-Year ENTC Engineering Project

**Project:** Light-Based Touchless Voting Machine with Dual-LDR Fraud Detection & Smart Idle Power Saver

