class cpm_input_sequencer extends uvm_sequencer #(cpm_packet);

    `uvm_component_utils(cpm_input_sequencer)

    function new (string name, uvm_component parent);

        super.new(name,parent);

    endfunction

endclass