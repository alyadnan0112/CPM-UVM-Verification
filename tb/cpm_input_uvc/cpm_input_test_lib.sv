class base_test extends uvm_test;

`uvm_component_utils(base_test)

cpm_input_testbench in_tb;

function new(string name, uvm_component parent);

    super.new(name,parent);

endfunction

virtual function void build_phase (uvm_phase phase);

    super.build_phase(phase);
  
   uvm_config_wrapper::set(this, "in_tb.in_env.in_agent.in_sequencer.run_phase", "default_sequence",cpm_input_seq::get_type());
                          
    in_tb = cpm_input_testbench::type_id::create("in_tb",this); 
  
    `uvm_info("base_test", "the build phase of the test is being executed",UVM_HIGH);
  
  uvm_config_int::set(this,"*","recording_detail",1);

  endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);

    uvm_top.print_topology();

endfunction
  


endclass