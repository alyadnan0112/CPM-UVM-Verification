# CPM UVM Verification Environment

A UVM-based verification environment for the CPM (Configurable Packet Modifier) DUT using SystemVerilog and UVM.

## Current Progress

### Register UVC
- Register transaction (`cpm_register_transaction`)
- Register sequencer
- Register driver
- Register interface integration using `uvm_config_db`
- Read and write protocol implementation
- Reset handling
- Register access logging with `uvm_info`

### Features
- Supports register read and write transactions
- Synchronous register protocol
- Handshake using `req` and `gnt`
- One-cycle delayed read data capture
- Clean driver architecture with separate read/write tasks

## UVC Structure

```
Sequence
    │
    ▼
Sequencer
    │
    ▼
Driver
    │
    ▼
Register Interface
    │
    ▼
CPM DUT
```

## Technologies
- SystemVerilog
- UVM (IEEE 1800.2)
- Cadence Xcelium

## Work in Progress
- Register Monitor
- Register Agent
- Register Sequences
- Scoreboard
- Environment Integration
- Functional Coverage
- Test Library

## Repository Goal

Build a complete reusable UVM verification environment for the CPM design while following standard UVM methodology and best practices.
