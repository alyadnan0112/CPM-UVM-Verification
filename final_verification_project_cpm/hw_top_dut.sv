module hw_top;

  logic clk;
  logic rst;

  cpm_output_interface out_if(clk, rst);
  cpm_register_interface reg_if(clk, rst);
  cpm_input_interface in_if(clk, rst, out_if.out_valid);

cpm dut(
    .clk(clk),
    .rst(rst),

  // Stream input
  .in_valid(in_if.in_valid),
  .in_ready(in_if.in_ready),
  .in_id(in_if.in_id),
  .in_opcode(in_if.in_opcode),
  .in_payload(in_if.in_payload),

  // Stream output
    .out_valid(out_if.out_valid),
    .out_ready(out_if.out_ready),
    .out_id(out_if.out_id),
    .out_opcode(out_if.out_opcode),
    .out_payload(out_if.out_payload),

  // Register bus
    .req(reg_if.req),
    .gnt(reg_if.gnt),
    .write_en(reg_if.write_en),
    .addr(reg_if.addr),
    .wdata(reg_if.wdata),
    .rdata(reg_if.rdata)
);
  initial begin
         clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    repeat(5) @(posedge clk);
    rst = 0;
    rst = 1;
        rst = 0;
  end

endmodule