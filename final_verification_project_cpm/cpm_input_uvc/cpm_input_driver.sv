class cpm_input_driver extends uvm_driver #(cpm_packet);
  
   virtual interface cpm_input_interface vif;

    `uvm_component_utils(cpm_input_driver)
    `uvm_register_cb(cpm_input_driver,cpm_input_driver_callback)        //callback

    function new(string name, uvm_component parent);

        super.new(name,parent);

    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!cpm_input_vif_config::get(this,"","vif",vif))
         `uvm_error("NO VIF","vif not set")
        
        endfunction

    task run_phase(uvm_phase phase);

            vif.in_valid<=0;
            vif.in_id<=0;
            vif.in_payload<=0;
            vif.in_opcode<=0;
        
        wait(vif.rst==0);

        forever begin

            if(vif.rst) begin
            vif.in_valid<=0;
            vif.in_id<=0;
            vif.in_payload<=0;
            vif.in_opcode<=0;
            end


        wait(vif.rst==0);

        seq_item_port.get_next_item(req);

            `uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s", req.sprint()), UVM_HIGH)

            `uvm_do_callbacks(cpm_input_driver,cpm_input_driver_callback,pre_drive(this, req))  // pre callback
            send_to_dut(req);
            `uvm_do_callbacks(cpm_input_driver,cpm_input_driver_callback,post_drive(this, req)) // post callback

        seq_item_port.item_done();

        end

    endtask

    task send_to_dut(cpm_packet pkt);
        
        @(posedge vif.clk);

            vif.in_valid<=1;
            vif.in_id<=pkt.id;
            vif.in_payload<=pkt.payload;
            vif.in_opcode<=pkt.opcode;

        forever begin
            @(posedge vif.clk);

            
        if(vif.rst) begin
            vif.in_valid   <= 0;
            vif.in_id      <= 0;
            vif.in_opcode  <= 0;
            vif.in_payload <= 0;
        return;
            end

            if(vif.in_ready) // if in_ready = 1, go out of the forever loop
            break;
        end 

            vif.in_valid<=0;

    endtask

endclass