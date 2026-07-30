class cpm_reg_driver extends uvm_driver #(cpm_register_transaction);

    virtual interface cpm_reg_interface reg_if;
    `uvm_component_utils(cpm_reg_driver)
    cpm_register_transaction req;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!cpm_reg_vif_config::get(this,"","reg_if",reg_if))
            `uvm_error("NO VIF","reg_if not set")

    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        reset_signals();

        forever begin

            seq_item_port.get_next_item(req);

             `uvm_info(get_type_name(),
                  $sformatf("Received Register Transaction:\n%s",
                            req.sprint()),
                  UVM_HIGH);

            if (req.write_en) begin
                write_register();
            end
            else begin
                read_register();
            end

            seq_item_port.item_done();
        end
    
    endtask

    task reset_signals();

        @(posedge reg_if.clk);

        reg_if.req <= 0;
        reg_if.write_en <= 0;
        reg_if.addr <= 0;
        reg_if.wdata <= 0;

    endtask

    task write_register();
            
        @(posedge reg_if.clk);

        reg_if.addr <= req.addr;
        reg_if.write_en <= req.write_en;
        reg_if.wdata <= req.wdata;

        reg_if.req <= 1'b1;

        wait(reg_if.gnt);

        @(posedge reg_if.clk);
        reg_if.req <= 1'b0;

    endtask

    task read_register();
        
        @(posedge reg_if.clk);

        reg_if.addr <= req.addr;
        reg_if.write_en <= req.write_en;
        reg_if.req <= 1'b1;

        wait(reg_if.gnt);

        @(posedge reg_if.clk);

        req.rdata = reg_if.rdata;
        reg_if.req <= 1'b0;
        
    endtask

endclass