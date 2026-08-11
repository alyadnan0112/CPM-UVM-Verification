class cpm_register_driver extends uvm_driver #(cpm_register_transaction);

    virtual interface cpm_register_interface reg_if;

    `uvm_component_utils(cpm_register_driver)
 

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!cpm_register_vif_config::get(this,"","vif",reg_if))
            `uvm_error("NO VIF","reg_if not set")

    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        reset_signals();
        
        forever begin

            seq_item_port.get_next_item(req);

            if (req.write_en) begin
                write_register();
            end
            else begin
                read_register();
            end
                //          `uvm_info(get_type_name(),
                //   $sformatf("Received Register Transaction:\n%s",
                //             req.sprint()),
            //      UVM_HIGH);
            seq_item_port.item_done();
        end
    
    endtask

    task reset_signals();
wait (reg_if.rst == 1'b0);
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

        @(posedge reg_if.clk);
        req.req    = reg_if.req;
         req.gnt = reg_if.gnt;
        reg_if.req <= 1'b0;

    endtask

    task read_register();
        
        @(posedge reg_if.clk);

        reg_if.addr <= req.addr;
        reg_if.write_en <= req.write_en;
        reg_if.req <= 1'b1;
        reg_if.wdata    <= '0;


        @(posedge reg_if.clk);
        req.req    = reg_if.req;
        req.gnt    = reg_if.gnt; 
        reg_if.req <= 1'b0;

         @(posedge reg_if.clk);

        req.rdata = reg_if.rdata;
        reg_if.req <= 1'b0;
        
    endtask

endclass