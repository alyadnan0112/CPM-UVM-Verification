class cpm_input_driver_callback extends uvm_callback;

    `uvm_object_utils(cpm_input_driver_callback)

    function new(string name="cpm_input_driver_callback");
        super.new(name);
    endfunction

    virtual task pre_drive(
        cpm_input_driver drv,
        ref cpm_packet pkt
    );

    `uvm_info(get_type_name(),"Payload Corrupted", UVM_LOW)
    pkt.payload = 16'hFFFF;
    
    endtask

    virtual task post_drive(
        cpm_input_driver drv,
        cpm_packet pkt
    );
    endtask

endclass