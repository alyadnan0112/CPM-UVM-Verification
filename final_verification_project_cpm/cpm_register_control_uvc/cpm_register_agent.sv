class cpm_register_agent extends uvm_agent;

`uvm_component_utils(cpm_register_agent)

cpm_register_sequencer reg_sequencer;
cpm_register_driver reg_driver;
cpm_register_monitor reg_monitor;

function new(string name = "cpm_register_agent", uvm_component parent = null);

    super.new(name, parent);
    
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

if (!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active))
`uvm_fatal("CFG", "Failed to get is_active")

    reg_monitor = cpm_register_monitor::type_id::create("reg_monitor", this);

    if(is_active == UVM_ACTIVE) begin
        reg_sequencer = cpm_register_sequencer::type_id::create("reg_sequencer", this);
        reg_driver = cpm_register_driver::type_id::create("reg_driver", this);
    end

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if(is_active == UVM_ACTIVE) begin
        reg_driver.seq_item_port.connect(reg_sequencer.seq_item_export);
    end

endfunction

endclass