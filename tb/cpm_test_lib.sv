class base_test extends uvm_test;

`uvm_component_utils(base_test)

cpm_testbench tb;

function new(string name, uvm_component parent);

    super.new(name,parent);

endfunction

virtual function void build_phase (uvm_phase phase);

    super.build_phase(phase);
  
   uvm_config_wrapper::set(this, "tb.in_env.in_agent.in_sequencer.run_phase", "default_sequence",cpm_input_seq::get_type());
   uvm_config_wrapper::set(this, "tb.out_env.out_agent.out_sequencer.run_phase", "default_sequence",cpm_output_seq::get_type());
   uvm_config_wrapper::set(this, "tb.reg_env.reg_agent.reg_sequencer.run_phase", "default_sequence",cpm_register_seq::get_type());
                          
    tb = cpm_testbench::type_id::create("tb",this); 
  
    `uvm_info("base_test", "the build phase of the test is being executed",UVM_HIGH);
  
  uvm_config_int::set(this,"*","recording_detail",1);

  endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);

    uvm_top.print_topology();

endfunction
  


endclass