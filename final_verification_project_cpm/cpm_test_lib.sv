class base_test extends uvm_test;

`uvm_component_utils(base_test)

cpm_testbench tb;

cpm_mcseq cpm_seq;

function new(string name, uvm_component parent);

    super.new(name,parent);

endfunction

virtual function void build_phase (uvm_phase phase);

    super.build_phase(phase);
  
    cpm_seq = cpm_mcseq::type_id::create("cpm_seq");


    tb = cpm_testbench::type_id::create("tb",this); 
  

    `uvm_info("base_test", "the build phase of the test is being executed",UVM_HIGH);
  
 // uvm_config_int::set(this,"*","recording_detail",1);

  endfunction
 virtual task run_phase(uvm_phase phase);
    
    uvm_objection obj = phase.get_objection();
    
    obj.set_drain_time(this,1000ns);

     phase.raise_objection(this);

     cpm_seq.start(tb.cpm_mc_seqr);

     phase.drop_objection(this);
    
  endtask

virtual function void end_of_elaboration_phase(uvm_phase phase);

    uvm_top.print_topology();

endfunction
  
endclass



class register_rw_test extends base_test;

    `uvm_component_utils(register_rw_test)

    register_rw_seq rw_seq;

    function new(string name="register_rw_test",
                 uvm_component parent=null);
        super.new(name,parent);
    endfunction


    virtual task run_phase(uvm_phase phase);

        `uvm_info("REGISTER_RW_TEST",
                  "Inside register_rw_test run_phase",
                  UVM_NONE)

        phase.raise_objection(this);

        rw_seq = register_rw_seq::type_id::create("rw_seq");

        rw_seq.rm = tb.cpm_rm;

        rw_seq.start(null);

        `uvm_info("REGISTER_RW_TEST",
              "REGISTER_RW_TEST completed successfully.",
              UVM_LOW)

        phase.drop_objection(this);

    endtask

endclass

class corner_test extends base_test;

    `uvm_component_utils(corner_test)

    corner_seq c_seq;

    function new(string name="corner_test",
                 uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);

        `uvm_info("CORNER_TEST",
                  "Inside corner_test run_phase",
                  UVM_NONE)

        phase.raise_objection(this);

        c_seq = corner_seq::type_id::create("c_seq");

        c_seq.rm = tb.cpm_rm;

        c_seq.start(null);

        `uvm_info("CORNER_TEST",
                  "CORNER_TEST PASSED: All corner-case register configurations executed successfully.",
                  UVM_LOW)

        phase.drop_objection(this);

    endtask

endclass

class factory_override_test extends base_test;

    `uvm_component_utils(factory_override_test)

    function new(string name="factory_override_test",
                 uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);

        // Override cpm_input_seq with factory_input_seq
        cpm_input_seq::type_id::set_type_override(
            factory_input_seq::get_type());

        super.build_phase(phase);

        `uvm_info("FACTORY_OVERRIDE_TEST",
                  "Factory override applied: cpm_input_seq -> factory_input_seq",
                  UVM_LOW)

    endfunction

    virtual task run_phase(uvm_phase phase);

        `uvm_info("FACTORY_OVERRIDE_TEST",
                  "Running Factory Override Test",
                  UVM_NONE)

        super.run_phase(phase);

        `uvm_info("FACTORY_OVERRIDE_TEST",
                  "FACTORY_OVERRIDE_TEST PASSED",
                  UVM_LOW)

    endtask

endclass

class drop_test extends base_test;

    `uvm_component_utils(drop_test)

    function new(string name="drop_test",
                 uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);

        cpm_input_seq::type_id::set_type_override(
            drop_test_seq::get_type());

        super.build_phase(phase);

    endfunction

endclass

class random_inorder_test extends base_test;

    `uvm_component_utils(random_inorder_test)

    function new(string name = "random_inorder_test",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        // Set the default input sequence
        uvm_config_wrapper::set(
            this,
            "tb.cpm_mc_seqr.run_phase",
            "default_sequence",
            cpm_mcseq::get_type()
        );

    endfunction

endclass