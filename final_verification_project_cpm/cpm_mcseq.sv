class cpm_mcseq extends uvm_sequence;

      `uvm_object_utils(cpm_mcseq)
        `uvm_declare_p_sequencer(cpm_mcsequencer)

        cpm_input_seq in_seq;
      //  config_seq conf_seq;
      //   all_modes_sequence all_mode_seq;
      //   runtime_config_change_sequence runtime_seq;
      //coverage_seq cov_seq;
      ral_check_seq check_seq;

        cpm_output_seq out_seq;

function new(string name = "cpm_mcseq");

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

virtual task body();

// conf_seq = config_seq::type_id::create("conf_seq");
// conf_seq.rm = p_sequencer.rm;


// all_mode_seq = all_modes_sequence::type_id::create("all_mode_seq");
// all_mode_seq.rm = p_sequencer.rm;

// runtime_seq = runtime_config_change_sequence::type_id::create("runtime_seq");
// runtime_seq.rm = p_sequencer.rm;

// cov_seq = coverage_seq::type_id::create("cov_seq");
// cov_seq.rm = p_sequencer.rm;

check_seq = ral_check_seq::type_id::create("check_seq");
check_seq.rm = p_sequencer.rm;

fork
  `uvm_do_on(in_seq, p_sequencer.in_seqr)
  //conf_seq.start(p_sequencer.reg_seqr); 
 //all_mode_seq.start(p_sequencer.reg_seqr); 
//  runtime_seq.start(p_sequencer.reg_seqr); 
 //cov_seq.start(p_sequencer.reg_seqr); 
 check_seq.start(p_sequencer.reg_seqr); 
  `uvm_do_on(out_seq, p_sequencer.out_seqr)

join
endtask



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

endclass