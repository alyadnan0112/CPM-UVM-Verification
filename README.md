# Verification Components

## Input UVC (Active)
- Transaction
- Sequences
- Sequencer
- Driver
- Monitor
- Agent
- Environment

---

## Register UVC (Active)
- Register Transaction
- Register Sequences
- Register Sequencer
- Register Driver
- Register Monitor
- Register Agent
- Register Environment

---

## Output UVC (Active)
- Transaction
- Sequences
- Sequencer
- Driver
- Monitor
- Agent
- Envrionment

---

## Virtual Layer

- Virtual Sequencer
- Virtual Sequences

Coordinates all UVCs by synchronizing the Input, Register, and Output agents to execute complete system-level verification scenarios.

---

# Verification Architecture

```
                          Test
                           |
                           |
                  Virtual Sequence
                           |
                    Virtual Sequencer
             _________/      |      \_________
            /                |                \
           /                 |                 \
    Input UVC          Register UVC        Output UVC
           \                 |                 /
            \                |                /
                     +------------------+
                     |     CPM DUT      |
                     +------------------+
                              |
                    Scoreboard & Coverage
```

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
                +-------------------+          +-------------------+
                |                                           |
        +-------v--------+                         +---------v--------+
        |  Input Seqr    |                         | Register Seqr    |
        +-------+--------+                         +---------+--------+
                |                                            |
        +-------v--------+                         +---------v--------+
        | Input Driver   |                         | Register Driver  |
        +-------+--------+                         +---------+--------+
                |                                            |
                +----------------+---------------+------------+
                                 |               |
                                 |               |
                           +-----v---------------v-----+
                           |         CPM DUT           |
                           +-----+---------------+-----+
                                 |               |
                                 |               |
                         +-------v--------+      |
                         | Output Driver  |      |
                         +-------+--------+      |
                                 |               |
                         +-------v--------+      |
                         | Output Monitor |      |
                         +-------+--------+      |
                                 |               |
          +----------------------+---------------+--------------------+
          |                                                       |
          |                                                       |
 +--------v--------+                                   +----------v----------+
 |   Scoreboard    |                                   | Functional Coverage |
 +-----------------+                                   +---------------------+
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
│   ├── agent
│   └── environment
│
├── register_uvc/
│   ├── transaction
│   ├── sequences
│   ├── sequencer
│   ├── driver
│   ├── monitor
│   ├── environment
│   └── agent
│
├── output_uvc/
│   ├── transaction
│   ├── sequences
│   ├── sequencer
│   ├── driver
│   ├── monitor
│   ├── environment
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

<p align="center">
  <img src="images/cpm_block_diagram.png" width="900">
</p>

---

## Verification Environment Block Diagram

<p align="center">
  <img src="images/verification_environment.png" width="900">
</p>
