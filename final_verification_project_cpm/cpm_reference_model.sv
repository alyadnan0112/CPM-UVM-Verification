class cpm_reference_model extends uvm_component;

    `uvm_component_utils(cpm_reference_model)

    `uvm_analysis_imp_decl(_packet)
    `uvm_analysis_imp_decl(_reg)

    // Analysis Imports
    uvm_analysis_imp_packet #(cpm_packet, cpm_reference_model) packet_in;
    uvm_analysis_imp_reg #(cpm_register_transaction, cpm_reference_model) register_in;

    // Expected Packet Output
    uvm_analysis_port #(output_transaction) expected_packet_port;

    // Coverage Output
uvm_analysis_port #(coverage_transaction) coverage_port;

    // CTRL Register (0x00)
    bit CTRL_ENABLE;
    bit CTRL_SOFT_RST;

    // MODE Register (0x04)
    bit [1:0] MODE;

    // PARAMS Register (0x08)
    bit [15:0] MASK;
    bit [15:0] ADD_CONST;

    // DROP_CFG Register (0x0C)
    bit DROP_EN;
    bit [3:0] DROP_OPCODE;

    // STATUS Register (0x10)
    bit STATUS_BUSY;

    // Reference Model Counters
    int COUNT_IN;
    int COUNT_OUT;
    int DROPPED_COUNT;

    function new(string name="cpm_reference_model", uvm_component parent=null);
        super.new(name,parent);

        packet_in = new("packet_in", this);
        register_in = new("register_in", this);
        expected_packet_port = new("expected_packet_port", this);
        coverage_port = new("coverage_port",this);

        CTRL_ENABLE = 0;
        CTRL_SOFT_RST = 0;

        MODE = 2'b00;

        MASK = 16'h0000;
        ADD_CONST = 16'h0000;

        DROP_EN = 0;
        DROP_OPCODE = 4'h0;

        STATUS_BUSY = 0;

        COUNT_IN = 0;
        COUNT_OUT = 0;
        DROPPED_COUNT = 0;

    endfunction

    // Register Transaction Callback
    function void write_reg(input cpm_register_transaction reg_txn);

        if (!reg_txn.write_en)  // Ignore register reads
            return;

        case (reg_txn.addr)

            8'h00:   // CTRL Register (0x00)
            begin
                CTRL_ENABLE   = reg_txn.wdata[0];
                CTRL_SOFT_RST = reg_txn.wdata[1];

                // Soft Reset
                if (CTRL_SOFT_RST) begin

                    CTRL_ENABLE = 0;
                    MODE = 2'b00;
                    MASK = 16'h0000;
                    ADD_CONST = 16'h0000;
                    DROP_EN = 0;
                    DROP_OPCODE = 4'h0;
                    STATUS_BUSY = 0;
                    COUNT_IN  = 0;
                    COUNT_OUT = 0;
                    DROPPED_COUNT = 0;

                    CTRL_SOFT_RST = 0;  // Self-clear SOFT_RST bit

                    `uvm_info(get_type_name(),
                        "SOFT_RST asserted - CPM Reference Model Reset",
                        UVM_LOW)
                end
                else begin
                    `uvm_info(get_type_name(), $sformatf("CTRL Updated : ENABLE=%0b SOFT_RST=%0b",CTRL_ENABLE,CTRL_SOFT_RST),UVM_LOW)
                end
            end

            8'h04:   // MODE Register (0x04)
            begin
                MODE = reg_txn.wdata[1:0];

                `uvm_info(get_type_name(),$sformatf("MODE Updated : %0d", MODE),UVM_LOW)
            end

            8'h08:   // PARAMS Register (0x08)
            begin
                MASK = reg_txn.wdata[15:0];
                ADD_CONST = reg_txn.wdata[31:16];

                `uvm_info(get_type_name(),$sformatf("PARAMS Updated : MASK=0x%0h ADD_CONST=0x%0h",MASK, ADD_CONST),UVM_LOW)
            end

            8'h0C:  // DROP_CFG Register (0x0C)
            begin
                DROP_EN = reg_txn.wdata[0];
                DROP_OPCODE = reg_txn.wdata[7:4];

                `uvm_info(get_type_name(),$sformatf("DROP_CFG Updated : DROP_EN=%0b DROP_OPCODE=%0h", DROP_EN,DROP_OPCODE),
                    UVM_LOW)
            end

            default:
            begin
                `uvm_warning(get_type_name(),$sformatf("Unknown Register Address : 0x%0h",reg_txn.addr))
            end

        endcase

    endfunction

    // Input Packet Callback
    function void write_packet(input cpm_packet pkt);

        output_transaction expected_pkt;
        coverage_transaction cov_tr;


        expected_pkt = output_transaction::type_id::create("expected_pkt");

        cov_tr = coverage_transaction::type_id::create("cov_tr");


        COUNT_IN++;  // Packet accepted
        STATUS_BUSY = 1;

        // for coverage
        cov_tr.mode = MODE;
        cov_tr.opcode = pkt.opcode;
        cov_tr.drop_event = 0;
        cov_tr.stall_event = 0;

        if (!CTRL_ENABLE) begin  // CPM disabled

            STATUS_BUSY = 0;

            `uvm_info(get_type_name(),"Packet ignored : CPM is disabled",UVM_LOW)

            return;

        end

        // Check Drop Configuration
        if (DROP_EN && (pkt.opcode == DROP_OPCODE)) begin

            DROPPED_COUNT++;
            STATUS_BUSY = 0;

            cov_tr.drop_event = 1;

            coverage_port.write(cov_tr);

            `uvm_info(get_type_name(),$sformatf("Packet Dropped : Opcode = %0h", pkt.opcode),UVM_LOW)

            return;
        end

        expected_pkt.id     = pkt.id;
        expected_pkt.opcode = pkt.opcode;

        case (MODE)
            2'b00:  // PASS Mode
            begin
                expected_pkt.payload = pkt.payload;

                `uvm_info(get_type_name(),"PASS Mode Applied",UVM_LOW)
            end

            2'b01:   // XOR Mode
            begin
                expected_pkt.payload = pkt.payload ^ MASK;

                `uvm_info(get_type_name(),$sformatf("XOR Mode : %0h ^ %0h = %0h",pkt.payload, MASK,expected_pkt.payload),UVM_LOW)
            end

            2'b10:   // ADD Mode
            begin
                expected_pkt.payload = pkt.payload + ADD_CONST;

                `uvm_info(get_type_name(),$sformatf("ADD Mode : %0h + %0h = %0h",pkt.payload,ADD_CONST,expected_pkt.payload),UVM_LOW)
            end

            2'b11:   // ROT Mode
            begin
            
                expected_pkt.payload  = {pkt.payload[11:0], pkt.payload[15:12]};

                `uvm_info(get_type_name(),
                    $sformatf("ROT Mode : %0h -> %0h", pkt.payload, expected_pkt.payload),
                    UVM_LOW)
            end

            default:
            begin
                expected_pkt.payload = pkt.payload;

                `uvm_warning(get_type_name(),"Unknown MODE. PASS assumed.")
            end

        endcase

        COUNT_OUT++;
        STATUS_BUSY = 0;

        `uvm_info(get_type_name(),
            $sformatf("Expected Packet:\n%s",expected_pkt.sprint()),UVM_MEDIUM)

        expected_packet_port.write(expected_pkt);
        

        coverage_port.write(cov_tr);


    endfunction

    function void report_phase(uvm_phase phase);

        super.report_phase(phase);

        `uvm_info(get_type_name(),
        $sformatf("COUNT_IN=%0d COUNT_OUT=%0d DROPPED_COUNT=%0d",COUNT_IN,COUNT_OUT,DROPPED_COUNT),UVM_LOW)
      if (COUNT_IN == COUNT_OUT + DROPPED_COUNT)
            `uvm_info(get_type_name(), $sformatf("PASS: COUNT_IN(%0d) = COUNT_OUT(%0d) + DROPPED_COUNT(%0d) = %0d", COUNT_IN,COUNT_OUT,DROPPED_COUNT,COUNT_OUT + DROPPED_COUNT), UVM_LOW)
else
  `uvm_info(get_type_name(),$sformatf("FAIL: COUNT_IN(%0d) != COUNT_OUT(%0d) + DROPPED_COUNT(%0d) = %0d",COUNT_IN,COUNT_OUT,DROPPED_COUNT, COUNT_OUT + DROPPED_COUNT),UVM_LOW)

    endfunction

endclass
