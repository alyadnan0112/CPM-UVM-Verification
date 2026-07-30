class cpm_reg_sequencer extends uvm_sequencer #(cpm_register_transaction);

    `uvm_component_utils(cpm_reg_sequencer)

    function new(string name, uvm_component parent);

        super.new(name, parent);
        
    endfunction //new()



endclass