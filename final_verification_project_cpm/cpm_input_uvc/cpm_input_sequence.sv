class cpm_input_sequence extends uvm_sequence #(cpm_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(cpm_input_sequence)

  // Constructor
  function new(string name="cpm_input_sequence");
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

endclass : cpm_input_sequence

class cpm_input_seq extends cpm_input_sequence;

    `uvm_object_utils(cpm_input_seq)

    function new(string name = "cpm_input_seq");

        super.new(name);

    endfunction

        virtual task body();

    `uvm_info(get_type_name(), "Executing cpm_input_seq ", UVM_LOW)

      repeat(200)
      `uvm_do(req)
      repeat(9)
      `uvm_do_with(req, {opcode == 5;})
   repeat(200)
      `uvm_do(req)
        endtask

endclass