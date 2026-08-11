package cpm_register_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"


typedef uvm_config_db#(virtual cpm_register_interface) cpm_register_vif_config;


`include "cpm_register_transaction.sv"
`include "cpm_register_monitor.sv"
`include "cpm_register_sequencer.sv"
`include "cpm_register_sequence.sv"
`include "cpm_register_driver.sv"
`include "cpm_register_agent.sv"
`include "cpm_register_env.sv"

endpackage 