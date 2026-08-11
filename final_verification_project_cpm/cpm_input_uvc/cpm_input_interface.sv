interface cpm_input_interface(input clk, input rst , input out_valid);

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

// property input_stable;
// @(posedge clk) disable iff(rst)

// (in_valid && !in_ready) |=> ($stable(in_id) && $stable(in_opcode) && $stable(in_payload));

// endproperty

// assert property(input_stable)
property input_stable;
  @(posedge clk) disable iff(rst)(in_valid && !in_ready)|=> (in_valid &&$stable({in_id, in_opcode, in_payload})) until_with (in_ready);
endproperty

assert property (input_stable)
else
    `uvm_error("INPUT_STABLE",
               "Input packet changed during backpressure");

// Cover backpressure event
cover property (
    @(posedge clk) disable iff(rst)
    in_valid && !in_ready
);

property latency;
@(posedge clk) disable iff(rst)

(in_valid && in_ready) |-> ##[0:2] out_valid;

endproperty

assert property(latency)
else
`uvm_error("latency","The out_valid is not asserted within 0-2 clock cycles");


 endinterface : cpm_input_interface