# Light-Based Touchless Voting Machine with Dual-LDR Fraud Detection & Smart Idle Power Saver

## Project Overview

The **Light-Based Touchless Voting Machine** is a digital voting system designed using FPGA-based digital logic and Verilog HDL.

The system uses **two Light Dependent Resistors (LDRs)** as touchless input sensors. A voter can provide an input by interrupting one of the light beams. The dual-LDR arrangement also provides a simple fraud-detection mechanism by identifying simultaneous activation of both sensors.

The system processes the sensor inputs using a voting FSM, detects invalid simultaneous activation, counts valid votes, displays the vote count on a 7-segment display, and provides visual and audible alerts.

A **smart idle power-saving concept** is also included, where the clock-gating logic becomes active only when the system detects an input activity.

---

## Key Features

* Touchless voting using light-based LDR inputs
* Dual-LDR fraud detection
* Finite State Machine (FSM) based voting control
* Automatic valid vote counting
* 7-segment vote-count display
* Green LED indication for valid voting
* Red LED and buzzer indication for fraud/invalid input
* Smart idle clock-gating concept
* Verilog HDL implementation
* EDA Playground simulation using Icarus Verilog

---

## Problem Statement

Traditional voting interfaces may require physical buttons or switches, which can introduce mechanical wear and physical contact.

This project explores a **touchless digital voting interface** using light-based sensors. In addition to detecting a valid voting input, the system uses two sensors to identify simultaneous activation as an invalid or potentially fraudulent condition.

The design also demonstrates a power-saving concept by reducing clock activity when there is no sensor input.

---

## Objectives

1. Design a touchless voting interface using LDR sensors.
2. Implement dual-LDR logic for valid-input and fraud detection.
3. Design an FSM to control the voting sequence.
4. Count valid votes using a digital counter.
5. Display the vote count using a 7-segment display.
6. Provide LED and buzzer alerts for system conditions.
7. Demonstrate an idle clock-gating concept for power saving.
8. Verify the complete design using Verilog simulation.

---

## System Architecture

The overall system follows this flow:

```text
        LDR A ─────┐
                   │
                   ▼
             ┌───────────────┐
        LDR B │ Fraud Detector│
        ─────►│ & Input Logic │
             └───────┬───────┘
                     │
          ┌──────────┴──────────┐
          │                     │
          ▼                     ▼
   Valid Input             Fraud Detected
          │                     │
          ▼                     ▼
    ┌───────────┐         ┌─────────────┐
    │ Voting FSM│         │ Alert Logic │
    └─────┬─────┘         └──────┬──────┘
          │                      │
          ▼                      ▼
   ┌─────────────┐        Red LED + Buzzer
   │ Vote Counter│
   └──────┬──────┘
          │
          ▼
   ┌─────────────┐
   │ 7-Segment   │
   │   Display   │
   └─────────────┘

       LDR A OR LDR B
             │
             ▼
      Clock Gating Logic
             │
             ▼
         Gated Clock
```

The detailed architecture is available in:

`docs/project_architecture.png`

---

## Dual-LDR Fraud Detection

The two LDR inputs are processed using simple digital logic.

| LDR A | LDR B | Condition             |
| ----: | ----: | --------------------- |
|     0 |     0 | No input              |
|     0 |     1 | Valid input           |
|     1 |     0 | Valid input           |
|     1 |     1 | Fraud / invalid input |

The logic is:

```text
Valid Input   = LDR A XOR LDR B

Fraud Detect  = LDR A AND LDR B
```

Therefore:

* XOR identifies when exactly one LDR is active.
* AND identifies simultaneous activation of both LDRs.

---

## FSM Design

The voting controller is implemented using a **Finite State Machine** with three states:

```text
        ┌─────────┐
        │  IDLE   │
        └────┬────┘
             │
       Valid Input
             │
             ▼
        ┌─────────┐
        │  VOTE   │
        └────┬────┘
             │
             ▼
           IDLE


        ┌─────────┐
        │  IDLE   │
        └────┬────┘
             │
      Fraud Detected
             │
             ▼
        ┌─────────┐
        │  FRAUD  │
        └────┬────┘
             │
             ▼
           IDLE
```

### FSM States

| State | Function                    |
| ----- | --------------------------- |
| IDLE  | Waits for sensor input      |
| VOTE  | Enables valid vote counting |
| FRAUD | Generates fraud alert       |

The detailed FSM diagram is available in:

`docs/fsm_design.png`

---

## Output Indications

| Condition             | Green LED | Red LED | Buzzer |
| --------------------- | --------- | ------- | ------ |
| No input              | OFF       | OFF     | OFF    |
| Valid vote            | ON        | OFF     | OFF    |
| Fraud / invalid input | OFF       | ON      | ON     |

The current vote count is provided to the 7-segment display module.

---

## Smart Idle Power Saver

The project includes a clock-gating concept for reducing unnecessary clock activity.

The system determines whether there is an active sensor input:

```text
System Active = LDR A OR LDR B
```

When sensor activity is absent, the gated clock remains inactive.

When an LDR input is detected, the gated clock becomes active.

> Note: The clock-gating module in this project demonstrates the digital-design concept. For production FPGA designs, dedicated clock-management resources or clock-enable techniques are generally preferred over ordinary combinational logic used as a global clock.

---

## Verilog Modules

The project is divided into modular Verilog HDL files.

| Module               | Description                                    |
| -------------------- | ---------------------------------------------- |
| `top_module.v`       | Integrates all system modules                  |
| `voting_fsm.v`       | Controls voting and fraud states               |
| `vote_counter.v`     | Counts valid votes                             |
| `fraud_detector.v`   | Detects valid and simultaneous LDR inputs      |
| `seven_segment.v`    | Converts vote count to 7-segment output        |
| `alert_controller.v` | Controls LEDs and buzzer                       |
| `clock_gating.v`     | Implements the smart idle clock-gating concept |

---

## Testbench

The testbench verifies different operating conditions of the voting system.

The following cases are included:

* Reset condition
* No LDR input
* Valid LDR A input
* Valid LDR B input
* Simultaneous LDR A and LDR B activation
* Additional valid voting input

Testbench file:

`testbench/voting_system_tb.v`

---

## Simulation

The design was simulated using **EDA Playground** with the **Icarus Verilog** simulator.

Simulation screenshots are available in:

```text
simulation/
├── eda_playground_simulation_1.png
└── eda_playground_simulation_2.png
```

The simulation documentation is available in:

`simulation/simulation_results.md`

---

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
│   ├── simulation_results.md
│   ├── eda_playground_simulation_1.png
│   └── eda_playground_simulation_2.png
│
└── docs/
    ├── project_architecture.png
    ├── fsm_design.png
    └── implementation.png
```

---

## Technologies Used

* Verilog HDL
* Digital Logic Design
* Finite State Machines
* FPGA-oriented Digital Design
* Icarus Verilog
* EDA Playground
* 7-Segment Display Logic
* LDR-based Digital Input

---

## Applications

The concept can be adapted for:

* Touchless voting demonstrations
* Digital logic laboratory projects
* Educational FPGA demonstrations
* Contactless user-input systems
* Secure input-interface prototypes

---

## Future Scope

Possible future improvements include:

* Multi-candidate voting support
* Voter authentication
* RFID or biometric authentication
* Improved sensor synchronization and debouncing
* Dedicated FPGA clock-management resources
* Vote data logging
* Tamper detection
* Secure vote storage
* Hardware implementation on a suitable FPGA development board

---

## Conclusion

The project demonstrates how digital logic, FSMs, sensor-based inputs, fraud detection, vote counting, display control, and power-saving concepts can be integrated into a single touchless voting system.

The design has been modularized using Verilog HDL and verified through simulation.

---

## Author

**Apurva Bagadi**

3rd Year ENTC Engineering Student

---

## License

This project is intended for **educational and academic purposes**.
