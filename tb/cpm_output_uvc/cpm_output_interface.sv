interface cpm_output_interface(input clk, input rst);


import uvm_pkg::*;
`include "uvm_macros.svh"

logic out_valid;
logic [3:0] out_id;
logic [3:0] out_opcode;
logic [15:0] out_payload;
logic out_ready;

task collect_packet(

    output logic [3:0] id,
    output logic [3:0] opcode,
    output logic [15:0] payload
 
);

id = out_id;
opcode = out_opcode;
payload = out_payload;

endtask

endinterface  