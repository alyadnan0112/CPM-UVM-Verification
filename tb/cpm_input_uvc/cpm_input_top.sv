module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import cpm_input_pkg::*;

  `include "cpm_input_uvc/cpm_input_testbench.sv"
  `include "cpm_input_uvc/cpm_input_test_lib.sv"

  bit clk;
  bit rst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #20;
    rst = 0;
  end

  cpm_input_interface in_if(clk, rst);

  // Dummy DUT behavior
  initial begin
    in_if.in_ready = 0;
    wait(rst == 0);
    in_if.in_ready = 1;
  end

  initial begin
    cpm_input_vif_config::set(
      null,
      "uvm_test_top.in_tb.in_env.*",
      "vif",
      in_if
    );

    run_test("base_test");
  end

endmodule