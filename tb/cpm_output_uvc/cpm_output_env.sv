class cpm_output_env extends uvm_env;
  
  `uvm_component_utils(cpm_output_env)
  
  function new(string name, uvm_component parent);
    
    super.new(name,parent);
    
  endfunction
  
  cpm_output_agent out_agent;
  
  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
      uvm_config_db#(uvm_active_passive_enum)::set(this,"out_agent","is_active",UVM_ACTIVE);

    out_agent = cpm_output_agent::type_id::create("out_agent",this);
    
  endfunction
  
  
endclass