package cpm_tb_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import cpm_input_pkg::*;
  import cpm_output_pkg::*;
  import cpm_register_pkg::*;
   import cdns_uvmreg_utils_pkg::*;
import cpm_regs_pkg::*;

`include "config_seq.sv"

  `include "coverage_transaction.sv"
  `include "cpm_coverage_subscriber.sv"
  
`include "cpm_reg_adapter.sv"
`include "cpm_mcsequencer.sv"
`include "cpm_mcseq.sv"
  `include "cpm_reference_model.sv"
  `include "cpm_scoreboard.sv"
  `include "cpm_testbench.sv"
  `include "cpm_test_lib.sv"

endpackage