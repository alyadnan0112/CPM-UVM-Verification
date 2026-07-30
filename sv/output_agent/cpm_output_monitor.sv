class cpm_output_monitor extends uvm_monitor;
    `uvm_component_utils(cpm_output_monitor)

    uvm_analysis_port #(cpm_packet) item_collected_port;
    virtual cpm_output_interface output_if;
    cpm_packet item_collected;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual cpm_output_interface)::get(this, "", "vif", output_if)) begin
            `uvm_fatal("NOVIF", "Virtual interface must set for cpm_output_monitor instance");
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @(posedge output_if.clk);

            if(output_if.out_valid && output_if.out_ready) begin

                item_collected = cpm_packet::type_id::create("item_collected");

                output_if.collect_packet(item_collected.id, item_collected.opcode, item_collected.payload);
                
                item_collected_port.write(item_collected);
            end
        end
    endtask

endclass