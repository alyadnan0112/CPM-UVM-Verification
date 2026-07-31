class cpm_output_monitor extends uvm_monitor;

    `uvm_component_utils(cpm_output_monitor)

    uvm_analysis_port #(output_transaction) item_collected_port;

    virtual cpm_output_interface output_if;

    output_transaction item_collected;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!cpm_output_vif_config::get(this, "", "vif", output_if)) begin
            `uvm_fatal("NOVIF", "Virtual interface must set for cpm_output_monitor instance");
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @(posedge output_if.clk);

            if(output_if.out_valid && output_if.out_ready) begin

                item_collected = output_transaction::type_id::create("item_collected");

                output_if.collect_packet(item_collected.id, item_collected.opcode, item_collected.payload);

                `uvm_info(get_type_name(),$sformatf("Collected packet:\n%s", item_collected.sprint()),UVM_MEDIUM)
                
                item_collected_port.write(item_collected);
            end
        end
    endtask

endclass