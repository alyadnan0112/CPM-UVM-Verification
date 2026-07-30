class cpm_output_sequencer extends uvm_sequencer #(cpm_packet);
`uvm_component_utils(cpm_output_sequencer)      //register with factory

function new(string name = "cpm_output_sequencer",uvm_component parent);
super.new(name,parent);

endfunction



endclass
