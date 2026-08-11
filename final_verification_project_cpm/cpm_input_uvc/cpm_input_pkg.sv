package cpm_input_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"


typedef uvm_config_db#(virtual cpm_input_interface) cpm_input_vif_config;


`include "cpm_transaction.sv"
`include "cpm_input_monitor.sv"
`include "cpm_input_sequencer.sv"
`include "cpm_input_sequence.sv"


typedef class cpm_input_driver;

`include "cpm_input_driver_callback.sv"
`include "cpm_input_driver.sv"
`include "cpm_input_agent.sv"
`include "cpm_input_env.sv"

endpackage 