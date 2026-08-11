interface cpm_register_interface(input clk, input rst);

import uvm_pkg::*;
`include "uvm_macros.svh"

// Actual Signals
logic req;
logic gnt;   
logic write_en;
logic [7:0] addr;
logic [31:0] wdata;
logic [31:0] rdata;


endinterface : cpm_register_interface

