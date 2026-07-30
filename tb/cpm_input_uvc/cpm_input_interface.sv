interface cpm_input_interface(input clk, input rst);

import uvm_pkg::*;
`include "uvm_macros.svh"

// Actual Signals
logic in_valid;
logic in_ready;   //output
logic [3:0] in_id;
logic [3:0] in_opcode;
logic [15:0] in_payload;

task collect_packet(
    output logic [3:0]id,
    output logic [3:0]opcode,
    output logic [15:0]payload
);

id = in_id;
opcode = in_opcode;
payload = in_payload;

endtask:collect_packet

endinterface : cpm_input_interface

