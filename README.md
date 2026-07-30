# CPM UVM Verification Environment

A reusable **UVM (Universal Verification Methodology)** based verification environment for the **Configurable Packet Modifier (CPM)** DUT.

The objective of this project is to develop a complete modular verification environment from scratch by implementing reusable UVCs, scoreboards, coverage, and test scenarios following standard UVM methodology.

---

# Project Overview

The CPM (Configurable Packet Modifier) receives packets from an input interface, modifies them according to programmable configuration registers, and transmits the modified packets through the output interface.

Configuration of the DUT is performed through a dedicated **Register Interface**, allowing software-like programming of operating modes such as packet processing, masking, addition, rotation, dropping packets, and status monitoring.

---

# Overall Verification Flow

```
                               +----------------------+
                               |         TEST         |
                               +----------+-----------+
                                          |
                                          |
                               +----------v-----------+
                               |   Virtual Sequence   |
                               +----------+-----------+
                                          |
                                          |
                               +----------v-----------+
                               | Virtual Sequencer    |
                               +----+----------+------+
                                    |          |
                     +--------------+          +---------------+
                     |                                 |
              +------v------+                  +-------v-------+
              | Input Seqr  |                  | Register Seqr |
              +------+------|                  +-------+-------+
                     |                                 |
                     |                                 |
              +------v------+                  +-------v-------+
              | Input Driver |                  | Register Drv |
              +------+------|                  +-------+-------+
                     |                                 |
                     +---------------+-----------------+
                                     |
                                     |
                               +-----v------+
                               |  CPM DUT   |
                               +-----+------+
                                     |
                                     |
                             +-------v--------+
                             | Output Driver* |
                             +-------+--------+
                                     |
                             +-------v--------+
                             | Output Monitor |
                             +-------+--------+
                                     |
                                     |
          +--------------------------+--------------------------+
          |                                                     |
          |                                                     |
 +--------v--------+                                  +---------v---------+
 |   Scoreboard    |                                  | Functional Cov.   |
 +-----------------+                                  +-------------------+

(*The Output UVC is passive and contains a monitor only.)
```

---

# Verification Components

## Input UVC (Active)
- Transaction
- Sequences
- Sequencer
- Driver
- Monitor
- Agent

---

## Register UVC (Active)
- Register Transaction
- Register Sequences
- Register Sequencer
- Register Driver
- Register Monitor
- Register Agent

---

## Output UVC (Passive)
- Transaction
- Monitor
- Agent

---

## Virtual Layer
- Virtual Sequencer
- Virtual Sequences

Coordinates multiple UVCs by simultaneously controlling the Input UVC and Register UVC to generate complete system-level test scenarios.

---

# Verification Architecture

```
                 Test
                  |
                  |
          Virtual Sequence
                  |
          Virtual Sequencer
          /               \
         /                 \
Input UVC               Register UVC
         \                 /
          \               /
             CPM DUT
                |
                |
           Output UVC
                |
                |
         Scoreboard/Coverage
```

---

# Project Structure

```
tb/
│
├── input_uvc/
│   ├── transaction
│   ├── sequences
│   ├── sequencer
│   ├── driver
│   ├── monitor
│   └── agent
│
├── register_uvc/
│   ├── transaction
│   ├── sequences
│   ├── sequencer
│   ├── driver
│   ├── monitor
│   └── agent
│
├── output_uvc/
│   ├── transaction
│   ├── sequences
│   ├── sequencer
│   ├── driver
│   ├── monitor
│   └── agent
│
├── virtual_sequences/
│
├── virtual_sequencer/
│
├── env/
│
├── scoreboard/
│
├── coverage/
│
├── tests/
│
└── top/
```

---

## CPM Block Diagram

> **Insert CPM DUT Block Diagram Here**

---

## Verification Environment Block Diagram

> **Insert Complete Verification Architecture Diagram Here**
