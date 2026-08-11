class cpm_testbench extends uvm_env;

//`uvm_component_utils(cpm_testbench)
// register model
 cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 cpm_rm; 

   `uvm_component_utils_begin(cpm_testbench)
     `uvm_field_object(cpm_rm, UVM_ALL_ON)
    `uvm_component_utils_end


    function new (string name, uvm_component parent);

        super.new(name,parent);

    endfunction

cpm_input_env in_env;
cpm_output_env out_env;
cpm_register_env reg_env;

cpm_scoreboard cpm_scb;
cpm_reference_model cpm_ref;

cpm_mcsequencer cpm_mc_seqr;

cpm_coverage_subscriber cov_sub;
cpm_input_driver_callback cb;         //for call back


// adapter and predictor 
cpm_reg_adapter cpm_adapter;
uvm_reg_predictor#(cpm_register_transaction) reg_predictor;

virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    in_env = cpm_input_env::type_id::create("in_env",this);
    out_env = cpm_output_env::type_id::create("out_env",this);
    reg_env = cpm_register_env::type_id::create("reg_env",this);

  cpm_scb = cpm_scoreboard::type_id::create("cpm_scb",this);
  cpm_ref = cpm_reference_model::type_id::create("cpm_ref", this);
  
  cov_sub = cpm_coverage_subscriber::type_id::create("cov_sub",this);

cpm_mc_seqr= cpm_mcsequencer::type_id::create("cpm_mc_seqr",this);
   cpm_rm = cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0::type_id::create("cpm_rm",this);

     cpm_rm.build();
     cpm_rm.lock_model();

     //create adapter and predictor
    cpm_adapter  = cpm_reg_adapter::type_id::create("cpm_adapter");


if (cpm_adapter == null)
  `uvm_fatal("ADAPTER", "Adapter not created")
else
  `uvm_info("ADAPTER", "Adapter created successfully", UVM_LOW)
    reg_predictor = uvm_reg_predictor#(cpm_register_transaction)::type_id::create("reg_predictor", this);

    //for call back
  cb = cpm_input_driver_callback::type_id::create("cb");
   


endfunction

virtual function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    // Add callback after all components have been built
    uvm_callbacks#(
        cpm_input_driver,
        cpm_input_driver_callback)::add(in_env.in_agent.in_driver,cb);

    in_env.in_agent.in_monitor.item_collected_port.connect(cpm_ref.packet_in);

    reg_env.reg_agent.reg_monitor.tr.connect(cpm_ref.register_in);

    cpm_ref.expected_packet_port.connect(cpm_scb.expected_fifo.analysis_export);

    out_env.out_agent.out_monitor.item_collected_port.connect(cpm_scb.output_fifo.analysis_export);

    // virtual sequencer set
    cpm_mc_seqr.in_seqr  = in_env.in_agent.in_sequencer;
    cpm_mc_seqr.reg_seqr = reg_env.reg_agent.reg_sequencer;
    cpm_mc_seqr.out_seqr = out_env.out_agent.out_sequencer;

    //connect coverage
    cpm_ref.coverage_port.connect(cov_sub.analysis_export);

    // connect the cpm_rm
    cpm_rm.default_map.set_sequencer(reg_env.reg_agent.reg_sequencer,cpm_adapter);

    // predictor
   reg_predictor.map = cpm_rm.default_map;
    reg_predictor.adapter = cpm_adapter;
    reg_env.reg_agent.reg_monitor.tr.connect(reg_predictor.bus_in);

    cpm_mc_seqr.rm = cpm_rm;

endfunction

endclass