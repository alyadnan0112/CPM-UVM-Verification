class output_transaction extends uvm_sequence_item;

rand bit out_ready;
bit [3:0] id;
bit [3:0] opcode;
bit [15:0] payload;


`uvm_object_utils_begin(output_transaction)
    `uvm_field_int(out_ready, UVM_ALL_ON)
     `uvm_field_int(id, UVM_ALL_ON)
     `uvm_field_int(opcode, UVM_ALL_ON)
        `uvm_field_int(payload, UVM_ALL_ON)
`uvm_object_utils_end

    function new(string name = "output_transaction");

        super.new(name);
        
    endfunction

endclass : output_transaction

