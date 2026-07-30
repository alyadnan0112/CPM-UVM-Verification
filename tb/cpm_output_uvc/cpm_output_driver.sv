class cpm_output_driver extends uvm_driver #(cpm_packet);

    virtual cpm_output_interface output_vif;
    `uvm_component_utils(cpm_output_driver)

    function new(string name = "cpm_output_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!output_vif_config::get(
            this,
            "output_vif",
            output_vif
        )
        `uvm_error("NOVIF", "Failed to get output_vif from config DB")
        )
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        


endclass