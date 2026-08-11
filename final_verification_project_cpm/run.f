-64

-timescale 1ns/1ns

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

-incdir ./cpm_input_uvc
-incdir ./cpm_output_uvc
-incdir ./cpm_register_control_uvc

./cpm_input_uvc/cpm_input_pkg.sv
./cpm_output_uvc/cpm_output_pkg.sv
./cpm_register_control_uvc/cpm_register_pkg.sv

./reg_verifier_dir/uvmreg/cdns_uvmreg_utils_pkg.sv
./reg_verifier_dir/uvmreg/cpm_regs_rdb.sv

 

./cpm_tb_pkg.sv

./cpm_input_uvc/cpm_input_interface.sv
./cpm_output_uvc/cpm_output_interface.sv
./cpm_register_control_uvc/cpm_register_interface.sv

//dut
./cpm_rtl.sv

hw_top_dut.sv
cpm_top.sv

-access +rwc \
+UVM_VERBOSITY=UVM_HIGH \
+UVM_TESTNAME=base_test \
+SVSEED=random