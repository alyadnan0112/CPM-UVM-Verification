module tb_top;

`include "uvm_macros.svh"

import uvm_pkg::*;
import cpm_input_pkg::*;
import cpm_output_pkg::*;
import cpm_register_pkg::*;
import cpm_tb_pkg::*;


  initial begin
    cpm_input_vif_config::set( null,"uvm_test_top.tb.in_env.*","vif", hw_top.in_if );
    cpm_output_vif_config::set( null,"uvm_test_top.tb.out_env.*","vif", hw_top.out_if );
    cpm_register_vif_config::set( null,"uvm_test_top.tb.reg_env.*","vif", hw_top.reg_if );

    run_test("base_test");
  end

endmodule