class cpm_reg_adapter extends uvm_reg_adapter;

  `uvm_object_utils(cpm_reg_adapter)

function new(string name = "cpm_reg_adapter");
  super.new();

  supports_byte_enable = 0; // CPM interface does not support byte enables
  provides_responses   = 0; // Driver updates the same transaction object
endfunction

// Convert RAL transaction -> Bus transaction
virtual function uvm_sequence_item reg2bus
(
  const ref uvm_reg_bus_op rw
);

cpm_register_transaction bus_tr;

bus_tr = cpm_register_transaction::type_id::create("bus_tr");

// Request is always asserted for a register access
bus_tr.req = 1'b1;

// Address
bus_tr.addr = rw.addr;

// Read / Write
if (rw.kind == UVM_WRITE)
  bus_tr.write_en = 1'b1;
else
  bus_tr.write_en = 1'b0;

// Write data
bus_tr.wdata = rw.data;

return bus_tr;

endfunction

// Convert Bus transaction -> RAL transaction
virtual function void bus2reg
(
  uvm_sequence_item bus_item,
  ref uvm_reg_bus_op rw
);

  cpm_register_transaction bus_tr;

  if (!$cast(bus_tr, bus_item))
    `uvm_fatal("CPM_REG_ADAPTER",
                "Failed to cast bus_item to cpm_register_transaction")

  // Transaction type
  if (bus_tr.write_en)
    rw.kind = UVM_WRITE;
  else
    rw.kind = UVM_READ;

  // Address
  rw.addr = bus_tr.addr;

  // Data
  if (bus_tr.write_en)
    rw.data = bus_tr.wdata;
  else
    rw.data = bus_tr.rdata;

  // Transaction status
  if (bus_tr.gnt)
    rw.status = UVM_IS_OK;
  else
    rw.status = UVM_NOT_OK;

endfunction

endclass : cpm_reg_adapter