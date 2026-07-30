class cpm_input_agent extends uvm_agent;

`uvm_component_utils(cpm_input_agent)

cpm_input_sequencer in_sequencer;
cpm_input_driver in_driver;
cpm_input_monitor in_monitor;

    function new(string name = "cpm_input_agent", uvm_component parent = null);

        super.new(name, parent);
        
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        uvm_config_db#(uvm_active_passive_enum)::get
        (this, 
        "", 
        "is_active", 
        is_active
        );

        in_monitor = cpm_input_monitor::type_id::create("in_monitor", this);

        if(is_active == UVM_ACTIVE) begin
            in_sequencer = cpm_input_sequencer::type_id::create("in_sequencer", this);
            in_driver = cpm_input_driver::type_id::create("in_driver", this);
        end

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            in_driver.seq_item_port.connect(in_sequencer.seq_item_export);
        end

    endfunction

endclass