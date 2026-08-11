class cpm_mcsequencer extends uvm_sequencer;

    `uvm_component_utils(cpm_mcsequencer)

    cpm_input_sequencer in_seqr;
    cpm_register_sequencer reg_seqr;
    cpm_output_sequencer out_seqr;

cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

     function new(string name, uvm_component parent);
    
    super.new(name,parent);
    
  endfunction


endclass