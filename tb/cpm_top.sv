module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import cpm_input_pkg::*;
  import cpm_output_pkg::*;
  import cpm_register_pkg::*;

  `include "cpm_testbench.sv"
  `include "cpm_test_lib.sv"

  bit clk;
  bit rst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #20;
    rst = 0;
  end

  cpm_input_interface in_if(clk, rst);
  cpm_output_interface out_if(clk, rst);
  cpm_register_interface reg_if(clk, rst);

  // Dummy DUT behavior
  initial begin
    in_if.in_ready = 0;
    wait(rst == 0);
    in_if.in_ready = 1;
  end


initial begin
    out_if.out_valid   = 0;
    out_if.out_id      = 0;
    out_if.out_opcode  = 0;
    out_if.out_payload = 0;

    wait(rst == 0);

    forever begin
        @(posedge clk);

        if (out_if.out_ready) begin
            out_if.out_valid   <= 1;
            out_if.out_id      <= 4'h1;
            out_if.out_opcode  <= 4'h2;
            out_if.out_payload <= 16'h1234;

            @(posedge clk);

            out_if.out_valid <= 0;

          
        end
    end
end

//------------------------------------------------
// Dummy Register Interface (CPM DUT model)
//------------------------------------------------


// gnt must be same cycle as req
assign reg_if.gnt = reg_if.req;



// Read data generation
always_comb begin


    reg_if.rdata = 32'h12;


    if(reg_if.req && !reg_if.write_en) begin


        case(reg_if.addr)


            8'h00:
                reg_if.rdata = 32'h0000_0001;


            8'h04:
                reg_if.rdata = 32'h0000_0000;


            default:
                reg_if.rdata = 32'hDEAD_BEEF;


        endcase


    end


end

  initial begin
    cpm_input_vif_config::set( null,"uvm_test_top.tb.in_env.*","vif", in_if );
    cpm_output_vif_config::set( null,"uvm_test_top.tb.out_env.*","vif", out_if );
    cpm_register_vif_config::set( null,"uvm_test_top.tb.reg_env.*","vif", reg_if );

    run_test("base_test");
  end

endmodule