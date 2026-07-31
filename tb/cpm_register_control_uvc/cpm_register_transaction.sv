class cpm_register_transaction extends uvm_sequence_item;

rand bit req;
bit gnt;
rand bit write_en;
rand bit [7:0]addr;
rand bit [31:0]wdata;
bit [31:0]rdata;

`uvm_object_utils_begin(cpm_register_transaction)
    `uvm_field_int(req, UVM_ALL_ON)
    `uvm_field_int(gnt, UVM_ALL_ON)
    `uvm_field_int(write_en, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_field_int(rdata, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name = "cpm_register_transaction");

    super.new(name);
    
endfunction

endclass : cpm_register_transaction