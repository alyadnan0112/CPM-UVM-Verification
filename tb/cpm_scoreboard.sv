class cpm_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(cpm_scoreboard)

    uvm_tlm_analysis_fifo #(expected_transaction) expected_fifo;
    uvm_tlm_analysis_fifo #(output_transaction) output_fifo;

    uvm_get_port #(expected_transaction) exp_gp;
    uvm_get_port #(output_transaction) output_gp;

  function new(string name, uvm_component parent);
    
    super.new(name,parent);
    
  endfunction 

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    expected_fifo = new("expected_fifo", this);
    output_fifo = new("output_fifo", this);

    exp_gp = new("exp_gp", this);
    output_gp = new("output_gp", this);


  endfunction


  virtual function void connect_phase(uvm_phase phase);

        exp_gp.connect(expected_fifo.get_peek_export);
        output_gp.connect(output_fifo.get_peek_export);

  endfunction

  expected_transaction exp_pkt;
  output_transaction out_pkt;

  function bit ccomp (input expected_transaction exp_pkt, input output_transaction out_pkt, uvm_comparer comparer = null);

    if(comparer == null)
      comparer = new();

      ccomp = comparer.compare_field("id",exp_pkt.in_id,out_pkt.out_id,4);
      ccomp &= comparer.compare_field("opcode",exp_pkt.in_opcode,out_pkt.out_opcode,4);
      ccomp &= comparer.compare_field("payload",exp_pkt.in_payload,out_pkt.out_payload,16);

  endfunction

int packet_received;
int wrong_packet;
int matched_packet;

    task run_phase(uvm_phase phase);

        forever begin
            
            exp_gp.get(exp_pkt);
            output_gp.get(out_pkt);

            packet_received++;

            if(ccomp(exp_pkt,out_pkt)) begin
                
                matched_packet++;
                `uvm_info(get_type_name(),"Packet Matched",UVM_LOW)
            end

        else  begin
                wrong_packet++;
                `uvm_error(get_type_name(),"Packet Mismatched")

        end
        end
    endtask

        virtual function void check_phase(uvm_phase phase);

        if(!expected_fifo.is_empty())
            `uvm_error(get_type_name(),"Expected FIFO IS NOT EMPTY")

        if(!output_fifo.is_empty())
            `uvm_error(get_type_name(),"Output FIFO IS NOT EMPTY")

    endfunction

      virtual function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(),$sformatf("Packets Received = %0d, Matched = %0d, Wrong = %0d",packet_received,matched_packet, wrong_packet),UVM_LOW)

    endfunction

endclass
