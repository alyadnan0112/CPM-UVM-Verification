class cpm_packet extends uvm_sequence_item;

    rand bit [3:0] id;
    rand bit [3:0] opcode;
    rand bit [15:0] payload;

    `uvm_object_utils_begin(cpm_packet)
        `uvm_field_int(id, UVM_ALL_ON)
        `uvm_field_int(opcode, UVM_ALL_ON)
        `uvm_field_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "cpm_packet");

        super.new(name);
        
    endfunction //new()

endclass