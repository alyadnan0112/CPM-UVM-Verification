class coverage_transaction extends uvm_sequence_item;

    `uvm_object_utils(coverage_transaction)

    bit [1:0] mode;
    bit [3:0] opcode;

    bit drop_event;
    bit stall_event;

    function new(string name = "coverage_transaction");

    super.new(name);

    endfunction
endclass