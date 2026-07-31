class cpm_output_agent extends uvm_agent;

    `uvm_component_utils(cpm_output_agent)

    cpm_output_sequencer out_sequencer;
    cpm_output_driver out_driver;
    cpm_output_monitor out_monitor;

    function new(string name, uvm_component parent);

    super.new(name,parent);

    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        uvm_config_db#(uvm_active_passive_enum)::get(this,"", "is_active", is_active );

        out_monitor = cpm_output_monitor::type_id::create("out_monitor",this);

        if(is_active == UVM_ACTIVE) begin

        out_sequencer = cpm_output_sequencer::type_id::create("out_sequencer",this);
        out_driver = cpm_output_driver::type_id::create("out_driver",this);

        end

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            out_driver.seq_item_port.connect(out_sequencer.seq_item_export);
        end

    endfunction
endclass