class cpm_input_testbench extends uvm_sequencer;

    `uvm_component_utils(cpm_input_testbench)

    function new (string name, uvm_component parent);

        super.new(name,parent);

    endfunction

cpm_input_env in_env;

virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    in_env = cpm_input_env::type_id::create("in_env",this);

endfunction

endclass