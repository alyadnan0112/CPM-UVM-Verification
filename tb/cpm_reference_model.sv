class cpm_reference_model extends uvm_component;

    `uvm_component_utils(cpm_reference_model)

    uvm_analysis_imp #(cpm_packet, cpm_reference_model) input_imp;
    uvm_analysis_imp #(cpm_register_transaction, cpm_reference_model) register_imp;

    

    function new();
        
    endfunction //new()
endclass