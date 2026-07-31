class cpm_register_monitor extends uvm_monitor;

    `uvm_component_utils(cpm_register_monitor)

    virtual cpm_register_interface vif;

    uvm_analysis_port#(cpm_register_transaction) tr;

    function new(string name, uvm_component parent);

        super.new(name,parent);

    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        tr = new("tr",this);

          if(!cpm_register_vif_config::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface must set for cpm_register_monitor instance");
        end

    endfunction

    task run_phase(uvm_phase phase);

        cpm_register_transaction trans;

        forever begin
            
            @(posedge vif.clk);
            
            if(vif.req && vif.gnt) begin

            trans = cpm_register_transaction::type_id::create("trans",this);
            
            trans.req = vif.req;
            trans.gnt = vif.gnt;
            trans.write_en = vif.write_en;
            trans.wdata = vif.wdata;
            trans.addr = vif.addr;

            if(!vif.write_en) begin
                
                @(posedge vif.clk);

                trans.rdata = vif.rdata;

            end
         `uvm_info(get_type_name(),$sformatf("Collected packet:\n%s", trans.sprint()), UVM_MEDIUM)

            tr.write(trans);

            end


        end

    endtask
endclass