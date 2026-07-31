-64

-timescale 1ns/1ns

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

//-incdir ./sv
-incdir ./cpm_input_uvc
-incdir ./cpm_output_uvc
-incdir ./cpm_register_control_uvc

./cpm_input_uvc/cpm_input_pkg.sv
./cpm_output_uvc/cpm_output_pkg.sv
./cpm_register_control_uvc/cpm_register_pkg.sv
 
./cpm_input_uvc/cpm_input_interface.sv
./cpm_output_uvc/cpm_output_interface.sv
./cpm_register_control_uvc/cpm_register_interface.sv

cpm_top.sv

-access +rwc \
+UVM_VERBOSITY=UVM_HIGH \
+UVM_TESTNAME=base_test \
+SVSEED=random