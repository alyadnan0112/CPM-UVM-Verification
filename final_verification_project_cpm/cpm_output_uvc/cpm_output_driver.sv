class cpm_output_driver extends uvm_driver #(output_transaction);

`uvm_component_utils(cpm_output_driver)

virtual cpm_output_interface vif;

function new(string name="cpm_output_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!cpm_output_vif_config::get(this,"","vif",vif))

`uvm_error("NO VIF","vif not set")

endfunction


task run_phase(uvm_phase phase);

forever begin 
seq_item_port.get_next_item(req);
//`uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s", req.sprint()), UVM_HIGH)

send_to_dut(req);
seq_item_port.item_done();
end

endtask

task send_to_dut(output_transaction pkt);

@(posedge vif.clk);

vif.out_ready = pkt.out_ready;

endtask


endclass




