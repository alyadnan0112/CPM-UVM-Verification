class cpm_register_sequence extends uvm_sequence #(cpm_register_transaction);
  
  // Required macro for sequences automation
  `uvm_object_utils(cpm_register_sequence)

  // Constructor
  function new(string name="cpm_register_sequence");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : cpm_register_sequence

class cpm_register_seq extends cpm_register_sequence;

    `uvm_object_utils(cpm_register_seq)

    function new(string name = "cpm_register_seq");
        super.new(name);
    endfunction

    virtual task body();

        `uvm_info(get_type_name(), "Executing cpm_register_seq ", UVM_LOW)

        // 1. ENABLE
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h00;      // CTRL
        req.wdata    = 32'h1;      // ENABLE = 1
        finish_item(req);

        // 2. PARAMS: set mask and add_const BEFORE testing XOR/ADD
        //    wdata[15:0]  = mask       (used by XOR)
        //    wdata[31:16] = add_const  (used by ADD)
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h08;          // PARAMS
        req.wdata    = 32'h12341234;   // mask=0x1234, add_const=0x1234
        finish_item(req);

        // 3. MODE = 0 (PASS)
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h0;      // PASS
        finish_item(req);

        // 4. MODE = 1 (XOR)
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h1;      // XOR
        finish_item(req);

        // 5. MODE = 2 (ADD)
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h2;      // ADD
        finish_item(req);

        // 6. MODE = 3 (ROT)
        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h3;      // ROT
        finish_item(req);

        req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h1;      // XOR
        finish_item(req);
                req = cpm_register_transaction::type_id::create("req");
        start_item(req);
        req.req      = 1;
        req.write_en = 1;
        req.addr     = 8'h04;      // MODE
        req.wdata    = 32'h1;      // XOR
        finish_item(req);
    endtask

endclass