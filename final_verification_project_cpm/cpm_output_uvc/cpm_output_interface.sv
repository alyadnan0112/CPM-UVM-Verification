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

// property output_stable;
// @(posedge clk) disable iff(rst)

// (out_valid && !out_ready) |=> ($stable(out_id) && $stable(out_opcode) && $stable(out_payload));


// endproperty

// assert property(output_stable)
// else 
//     `uvm_error("output_stable","output packet is not stable during backpressure")

property output_stable;
  @(posedge clk) disable iff (rst)
    (out_valid && !out_ready)|=> (out_valid && $stable({out_id, out_opcode, out_payload}))until_with (out_ready);
endproperty

assert property (output_stable)
else
  `uvm_error("OUTPUT_STABLE",
             "Output packet changed while out_ready was LOW")

endinterface