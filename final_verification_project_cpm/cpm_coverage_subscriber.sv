class cpm_coverage_subscriber extends uvm_subscriber #(coverage_transaction);

    `uvm_component_utils(cpm_coverage_subscriber)

    coverage_transaction tr;

    covergroup cg;

    mode_cp: coverpoint tr.mode {
            bins mode[] = {[0:3]};

    }

    opcode_cp: coverpoint tr.opcode {

        bins opcode[] = {[0:15] };
    }

    drop_cp: coverpoint tr.drop_event { 

        bins drop[] = {0,1};
    }


    cg_cross: cross mode_cp,opcode_cp;
    endgroup

    function new(string name, uvm_component parent);

    super.new(name,parent);

    tr = coverage_transaction::type_id::create("tr");

    cg = new();

    endfunction

    function void write(coverage_transaction t);

        tr = t;

        cg.sample();

    endfunction
    
endclass