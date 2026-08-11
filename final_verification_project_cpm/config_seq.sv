class config_seq extends uvm_sequence;

        `uvm_object_utils(config_seq)

        cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

        uvm_status_e status;

        function new(string name = "config_seq");

        super.new(name);

        endfunction
        
        task body();

            if(rm == null)
                    `uvm_fatal(get_type_name(),"there is no register model")

        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);
        rm.cpm_cpm_regs.ctrl_reg.mirror(status,UVM_CHECK);
        if (status == UVM_IS_OK) `uvm_info("RAL","CTRL register check PASSED",UVM_LOW)

        // Enable Drop
       rm.cpm_cpm_regs.drop_cfg_reg.drop_en.write(status,1);
       rm.cpm_cpm_regs.drop_cfg_reg.drop_en.mirror(status,UVM_CHECK);
       if (status == UVM_IS_OK) `uvm_info("RAL","CTRL register check PASSED",UVM_LOW)

       // Drop opcode
       rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.write(status,5);
       rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.mirror(status,UVM_CHECK);
       if (status == UVM_IS_OK) `uvm_info("RAL","CTRL register check PASSED",UVM_LOW)

        endtask
endclass

class all_modes_sequence extends uvm_sequence;

    `uvm_object_utils(all_modes_sequence)

    cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

    uvm_status_e status;

    function new(string name = "all_modes_sequence");
        super.new(name);
    endfunction

    task body();

        cpm_input_seq pkt_seq;

        if(rm == null)
            `uvm_fatal(get_type_name(),"There is no register model")

        `uvm_info(get_type_name(),
                  "Executing ALL_MODES_SEQUENCE",
                  UVM_LOW)

        // Enable CPM
        rm.cpm_cpm_regs.ctrl_reg.enable.write(status, 1);

        rm.cpm_cpm_regs.params_reg.mask.write(status, 16'h0002);
        rm.cpm_cpm_regs.params_reg.add_const.write(status, 16'h0002);

        //================ PASS MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b00);



        //================ XOR MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b01);

        //================ ADD MODE ================

        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b10);

        //================ ROT MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b11);

    endtask

endclass

class runtime_config_change_sequence extends uvm_sequence;

    `uvm_object_utils(runtime_config_change_sequence)

    cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

    uvm_status_e status;

    function new(string name="runtime_config_change_sequence");
        super.new(name);
    endfunction


    task body();

        cpm_input_seq pkt_seq;


        if(rm == null)
            `uvm_fatal(get_type_name(),
                       "There is no register model")


        `uvm_info(get_type_name(),
                  "Executing RUNTIME CONFIG CHANGE SEQUENCE",
                  UVM_LOW)


        // Enable CPM
        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);


        // Configure parameters
        rm.cpm_cpm_regs.params_reg.mask.write(status,16'h0002);

        rm.cpm_cpm_regs.params_reg.add_const.write(status,16'h0002);



        fork
            // Change mode during traffic
            begin


                #10ns;

                `uvm_info(get_type_name(),
                          "Changing MODE -> PASS",
                          UVM_LOW)

                rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b00);



                #20ns;

                `uvm_info(get_type_name(),
                          "Changing MODE -> XOR",
                          UVM_LOW)

                rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b01);



                #20ns;

                `uvm_info(get_type_name(),
                          "Changing MODE -> ADD",
                          UVM_LOW)

                rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b10);



                #20ns;

                `uvm_info(get_type_name(),
                          "Changing MODE -> ROT",
                          UVM_LOW)

                rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b11);



            end


        join


    endtask

endclass

//coverage
class coverage_seq extends uvm_sequence;

        `uvm_object_utils(coverage_seq)

        cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

        uvm_status_e status;

        function new(string name = "coverage_seq");

        super.new(name);

        endfunction
        
        task body();

            if(rm == null)
                    `uvm_fatal(get_type_name(),"there is no register model")

        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);

        // Enable Drop
       rm.cpm_cpm_regs.drop_cfg_reg.drop_en.write(status,1);

       // Drop opcode
       rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.write(status,5);

       rm.cpm_cpm_regs.params_reg.mask.write(status, 16'h0002);
        rm.cpm_cpm_regs.params_reg.add_const.write(status, 16'h0002);

repeat(50) begin
        //================ PASS MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b00);



        //================ XOR MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b01);

        //================ ADD MODE ================

        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b10);

        //================ ROT MODE ================
        rm.cpm_cpm_regs.mode_reg.mode.write(status, 2'b11);

end

        endtask
endclass


class ral_check_seq extends uvm_sequence;

    `uvm_object_utils(ral_check_seq)

    cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

    uvm_status_e status;
    uvm_reg_data_t data;

    function new(string name="ral_check_seq");
        super.new(name);
    endfunction

    task body();

        if(rm == null)
            `uvm_fatal(get_type_name(),"Register model is NULL")

        //----------------------------------------------------
        // CTRL REGISTER
        //----------------------------------------------------
        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);

        rm.cpm_cpm_regs.ctrl_reg.mirror(status,UVM_CHECK);
        if (status == UVM_IS_OK) `uvm_info("RAL","CTRL register check PASSED",UVM_LOW)

        //----------------------------------------------------
        // MODE REGISTER
        //----------------------------------------------------
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b10);

        rm.cpm_cpm_regs.mode_reg.mirror(status,UVM_CHECK);
        if (status == UVM_IS_OK) `uvm_info("RAL","mode register check PASSED",UVM_LOW)

        //----------------------------------------------------
        // PARAMS REGISTER
        //----------------------------------------------------
        rm.cpm_cpm_regs.params_reg.mask.write(status,16'h00FF);

        rm.cpm_cpm_regs.params_reg.add_const.write(status,16'h1234);

        rm.cpm_cpm_regs.params_reg.mirror(status,UVM_CHECK);
        if (status == UVM_IS_OK) `uvm_info("RAL","params register check PASSED",UVM_LOW)

        //----------------------------------------------------
        // DROP_CFG REGISTER
        //----------------------------------------------------
        rm.cpm_cpm_regs.drop_cfg_reg.drop_en.write(status,1);

        rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.write(status,4'h5);

        rm.cpm_cpm_regs.drop_cfg_reg.mirror(status,UVM_CHECK);
        if (status == UVM_IS_OK) `uvm_info("RAL","drop_cfg register check PASSED",UVM_LOW)

        //----------------------------------------------------
        // READ STATUS REGISTER (RO)
        //----------------------------------------------------
        rm.cpm_cpm_regs.status_reg.read(status,data);

        `uvm_info("RAL",$sformatf("STATUS = 0x%0h",data), UVM_LOW)

        
        //----------------------------------------------------
        // READ COUNT_OUT
        //----------------------------------------------------
        rm.cpm_cpm_regs.count_out_reg.read(status,data);

        `uvm_info("RAL",
                  $sformatf("COUNT_OUT = %0d",data),
                  UVM_LOW)

        //----------------------------------------------------
        // READ DROPPED_COUNT
        //----------------------------------------------------
        rm.cpm_cpm_regs.dropped_count_reg.read(status,data);

        `uvm_info("RAL",
                  $sformatf("DROPPED_COUNT = %0d",data),
                  UVM_LOW)

        `uvm_info(get_type_name(),
                  "RAL CHECK SEQUENCE COMPLETED",
                  UVM_LOW)
                  //----------------------------------------------------
        // READ COUNT_IN
        //----------------------------------------------------
        rm.cpm_cpm_regs.count_in_reg.read(status,data);

        `uvm_info("RAL",$sformatf("COUNT_IN = %0d",data),UVM_LOW)


    endtask

endclass

class corner_seq extends uvm_sequence;

    `uvm_object_utils(corner_seq)

    cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

    uvm_status_e status;

    function new(string name = "corner_seq");
        super.new(name);
    endfunction

    task body();

        // Check register model
        if(rm == null)
            `uvm_fatal(get_type_name(),"Register model is NULL")

        // Enable CPM
        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"Failed to enable CPM")


        // Configure PASS mode
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b00);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"PASS mode configuration failed")


        // Configure XOR mode
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b01);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"XOR mode configuration failed")


        // Configure minimum XOR mask
        rm.cpm_cpm_regs.params_reg.mask.write(status,16'h0000);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"Minimum MASK configuration failed")


        // Configure maximum XOR mask
        rm.cpm_cpm_regs.params_reg.mask.write(status,16'hFFFF);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"Maximum MASK configuration failed")


        // Configure ADD mode
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b10);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"ADD mode configuration failed")


        // Configure minimum ADD constant
        rm.cpm_cpm_regs.params_reg.add_const.write(status,16'h0000);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"Minimum ADD_CONST configuration failed")


        // Configure maximum ADD constant
        rm.cpm_cpm_regs.params_reg.add_const.write(status,16'hFFFF);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"Maximum ADD_CONST configuration failed")


        // Configure ROT mode
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b11);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"ROT mode configuration failed")


        // Enable packet dropping
        rm.cpm_cpm_regs.drop_cfg_reg.drop_en.write(status,1);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"DROP_EN configuration failed")


        // Configure drop opcode
        rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.write(status,4'hF);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"DROP_OPCODE configuration failed")


        `uvm_info(get_type_name(),"Corner configuration completed",UVM_LOW)

    endtask

endclass 

class drop_test_seq extends cpm_input_seq;

    `uvm_object_utils(drop_test_seq)

    function new(string name="drop_test_seq");
        super.new(name);
    endfunction

    virtual task body();

        `uvm_info(get_type_name(),
                  "Executing DROP_TEST sequence",
                  UVM_LOW)

        // 10 packets should PASS
        repeat(10)
            `uvm_do_with(req,{
                req.opcode != 5;
            })

        // 10 packets should DROP
        repeat(10)
            `uvm_do_with(req,{
                req.opcode == 5;
            })

        // 10 packets should PASS
        repeat(10)
            `uvm_do_with(req,{
                req.opcode != 5;
            })

    endtask

endclass

class factory_input_seq extends cpm_input_seq;

    `uvm_object_utils(factory_input_seq)

    function new(string name="factory_input_seq");
        super.new(name);
    endfunction

    virtual task body();

        `uvm_info(get_type_name(),
                  "Executing factory_input_seq",
                  UVM_LOW)

        `uvm_info(get_type_name(),"Packet 1 : Random",UVM_LOW)
        `uvm_do(req)

        `uvm_info(get_type_name(),"Packet 2 : Opcode = 5",UVM_LOW)
        `uvm_do_with(req,{req.opcode==5;})

        `uvm_info(get_type_name(),"Packet 3 : Payload = 0000",UVM_LOW)
        `uvm_do_with(req,{req.payload==16'h0000;})

        `uvm_info(get_type_name(),"Packet 4 : Payload = FFFF",UVM_LOW)
        `uvm_do_with(req,{req.payload==16'hFFFF;})

        `uvm_info(get_type_name(),"Packet 5 : Random",UVM_LOW)
        `uvm_do(req)

    endtask

endclass

class random_inorder_seq extends cpm_input_seq;

    `uvm_object_utils(random_inorder_seq)

    function new(string name = "random_inorder_seq");
        super.new(name);
    endfunction

    virtual task body();

        `uvm_info(get_type_name(),
                  "Executing RANDOM_INORDER_SEQ",
                  UVM_LOW)

        repeat (50) begin

            `uvm_do(req)

            `uvm_info(get_type_name(),
                      $sformatf("Transaction Sent:\n%s", req.sprint()),
                      UVM_MEDIUM)

        end

    endtask

endclass

class register_rw_seq extends uvm_sequence;

    `uvm_object_utils(register_rw_seq)

    cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 rm;

    uvm_status_e status;
    uvm_reg_data_t data;

    function new(string name = "register_rw_seq");
        super.new(name);
    endfunction

    task body();

        if(rm == null)
            `uvm_fatal(get_type_name(),"There is no register model")

        // CTRL : ENABLE
        rm.cpm_cpm_regs.ctrl_reg.enable.write(status,1);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"CTRL.ENABLE write failed")

        rm.cpm_cpm_regs.ctrl_reg.enable.read(status,data);

        if(status != UVM_IS_OK)
            `uvm_error(get_type_name(),"CTRL.ENABLE read failed")

        if(data !== 1)
            `uvm_error(get_type_name(),
                $sformatf("CTRL.ENABLE Expected=1 Actual=%0d",data))

        // MODE : PASS
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b00);
        rm.cpm_cpm_regs.mode_reg.mode.read(status,data);

        if(data !== 2'b00)
            `uvm_error(get_type_name(),"PASS mode failed")

        // MODE : XOR
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b01);
        rm.cpm_cpm_regs.mode_reg.mode.read(status,data);

        if(data !== 2'b01)
            `uvm_error(get_type_name(),"XOR mode failed")

        // MODE : ADD
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b10);
        rm.cpm_cpm_regs.mode_reg.mode.read(status,data);

        if(data !== 2'b10)
            `uvm_error(get_type_name(),"ADD mode failed")

        // MODE : ROT
        rm.cpm_cpm_regs.mode_reg.mode.write(status,2'b11);
        rm.cpm_cpm_regs.mode_reg.mode.read(status,data);

        if(data !== 2'b11)
            `uvm_error(get_type_name(),"ROT mode failed")

        // PARAMS : MASK
        rm.cpm_cpm_regs.params_reg.mask.write(status,16'hFFFF);
        rm.cpm_cpm_regs.params_reg.mask.read(status,data);

        if(data !== 16'hFFFF)
            `uvm_error(get_type_name(),"MASK mismatch")

        // PARAMS : ADD_CONST
        rm.cpm_cpm_regs.params_reg.add_const.write(status,16'h1234);
        rm.cpm_cpm_regs.params_reg.add_const.read(status,data);

        if(data !== 16'h1234)
            `uvm_error(get_type_name(),"ADD_CONST mismatch")

        // DROP ENABLE
        rm.cpm_cpm_regs.drop_cfg_reg.drop_en.write(status,1);
        rm.cpm_cpm_regs.drop_cfg_reg.drop_en.read(status,data);

        if(data !== 1)
            `uvm_error(get_type_name(),"DROP_EN mismatch")

        // DROP OPCODE
        rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.write(status,5);
        rm.cpm_cpm_regs.drop_cfg_reg.drop_opcode.read(status,data);

        if(data !== 5)
            `uvm_error(get_type_name(),"DROP_OPCODE mismatch")

    endtask

endclass