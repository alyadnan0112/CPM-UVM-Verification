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
     
     repeat(5)
      `uvm_do(req)

        endtask

endclass