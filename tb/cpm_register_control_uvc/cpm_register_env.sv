class cpm_register_env extends uvm_env;
  
  `uvm_component_utils(cpm_register_env)
  
  function new(string name, uvm_component parent);
    
    super.new(name,parent);
    
  endfunction
  
  cpm_register_agent reg_agent;
  
  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
      uvm_config_db#(uvm_active_passive_enum)::set(this,"reg_agent","is_active",UVM_ACTIVE);

    reg_agent = cpm_register_agent::type_id::create("reg_agent",this);
    
  endfunction
  
  
endclass