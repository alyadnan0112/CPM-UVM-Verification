package cpm_output_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"


typedef uvm_config_db#(virtual cpm_output_interface) cpm_output_vif_config;


`include "cpm_output_transaction.sv"
`include "cpm_output_monitor.sv"
`include "cpm_output_sequencer.sv"
`include "cpm_output_sequence.sv"
`include "cpm_output_driver.sv"
`include "cpm_output_agent.sv"
`include "cpm_output_env.sv"

endpackage 