# D Flip-Flop Verification using UVM (SystemVerilog)

## 📌 Overview
This project demonstrates the functional verification of a D Flip-Flop using the Universal Verification Methodology (UVM) in SystemVerilog.
The goal is to build a modular, reusable, and scalable UVM testbench to verify correct behavior of a synchronous D flip-flop under different input and reset conditions.

This repository is suitable for:   
- Learning UVM basics
- Academic mini-projects
- Interview preparation
- RTL verification practice

## 🎯 Design Under Test (DUT)
The DUT is a positive-edge triggered D Flip-Flop with reset.
**Features:**
- Samples input D on the rising edge of the clock
- Supports reset functionality
- Outputs stored value on Q

## 🧪 Verification Objectives
- Verify correct data transfer from D to Q on clock edge
- Verify reset behavior
- Ensure stability of output when clock is inactive
- Check DUT behavior across multiple randomized test cases

## 🏗️ UVM Testbench Architecture
The verification environment follows the standard UVM architecture:

```
Test
 └── Environment
     ├── Agent
     │   ├── Sequencer
     │   ├── Driver
     │   └── Monitor
     └── Scoreboard
```

**Key Components:**
- Sequence / Sequencer – Generates stimulus (D, reset)
- Driver – Drives signals to the DUT
- Monitor – Observes DUT inputs and outputs
- Scoreboard – Compares expected vs actual output
- Test – Configures and runs the verification scenario

## 📁 Project Directory Structure
DFF_UVM_Verification/   
│   
├── rtl/   
│   └── design.sv   
│   
├── tb/   
│   ├── interface.sv   
│   ├── sequence_item.sv   
│   ├── sequence.sv   
│   ├── sequencer.sv   
│   ├── driver.sv   
│   ├── monitor.sv   
│   ├── agent.sv   
│   ├── scoreboard.sv   
│   ├── environment.sv   
│   ├── test.sv   
│   └── testbench.sv     
│   
├── results/   
│   ├── waveforms/   
│   │   ├── dff_epwave_overview.png   
│   │   ├── dff_reset_check.png   
│   │   └── dff_data_capture.png   
│   └── logs/   
│       └── dff_uvm_simulation.log   
│   
└── README.md   

## ▶️ Simulation & Tools

This project can be simulated using:
- QuestaSim / ModelSim
- VCS
- Xcelium

## 📊 Verification Results
- All directed and randomized test cases passed
- Scoreboard reports zero mismatches
- DUT behaves correctly for reset and clock conditions

## 📚 Key Concepts Covered
- UVM Testbench Structure
- Transaction-level Modeling
- Driver-Monitor Communication
- Scoreboard-based Checking
- Reusable Verification Components

## 🚀 Future Enhancements
- Add functional coverage
- Support asynchronous reset
- Extend to JK / T Flip-Flop verification
- Add assertions (SVA)

## 👩‍💻 Author
Priyanka S   
Verification Enthusiast | SystemVerilog | UVM   

## 📜 License
This project is for educational purposes.   
Feel free to use, modify, and learn from it.   
