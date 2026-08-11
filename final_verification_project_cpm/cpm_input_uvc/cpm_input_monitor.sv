class cpm_input_monitor extends uvm_monitor;

uvm_analysis_port #(cpm_packet) item_collected_port;  //TLM port

`uvm_component_utils(cpm_input_monitor)                   // register with factory


virtual interface cpm_input_interface vif;            //virtual interface

cpm_packet pkt;           //handle

function new(string name="cpm_input_monitor", uvm_component parent);
super.new(name,parent);
item_collected_port = new("item_collected_port", this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!cpm_input_vif_config::get(this,"","vif",vif))
    `uvm_error("NOVIF","Virtual Interface not found")           //error message
endfunction

task run_phase(uvm_phase phase);
    forever begin
        @(posedge vif.clk);
        if(vif.in_valid && vif.in_ready) begin
    pkt = cpm_packet::type_id::create("pkt",this);

     begin_tr(pkt);   // start recording 


    vif.collect_packet(pkt.id,pkt.opcode,pkt.payload);
    item_collected_port.write(pkt);

      end_tr(pkt);   // End recording

   // `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
        end
    end   


endtask : run_phase

endclass : cpm_input_monitor