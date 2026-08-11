class cpm_output_sequence extends uvm_sequence #(output_transaction);
  
  // Required macro for sequences automation
  `uvm_object_utils(cpm_output_sequence)

  // Constructor
  function new(string name="cpm_output_sequence");
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

endclass : cpm_output_sequence

class cpm_output_seq extends cpm_output_sequence;

    `uvm_object_utils(cpm_output_seq)

    function new(string name = "cpm_output_seq");

        super.new(name);

    endfunction

        virtual task body();

    `uvm_info(get_type_name(), "Executing cpm_output_seq ", UVM_LOW)
     repeat(2)

   // `uvm_do(req)
   `uvm_do_with(req, { out_ready == 1; })
   repeat(10)
    `uvm_do_with(req, { out_ready == 0; })
     `uvm_do_with(req, { out_ready == 1; })

        endtask

endclass