class cpm_input_env extends uvm_env;
  
  `uvm_component_utils(cpm_input_env)
  
  function new(string name, uvm_component parent);
    
    super.new(name,parent);
    
  endfunction
  
  cpm_input_agent in_agent;
  
  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
      uvm_config_db#(uvm_active_passive_enum)::set(this,"in_agent","is_active",UVM_ACTIVE);

    in_agent = cpm_input_agent::type_id::create("in_agent",this);
    
  endfunction
  
  
endclass