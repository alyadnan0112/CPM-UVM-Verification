//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cpm_regs_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                count_in_reg
/////////////////////////////////////////////////////
class count_in_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(count_in_reg_c)
  rand uvm_reg_field non_reserved_auto_added_field;
  
  covergroup wr_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    non_reserved_auto_added_field = fld_set[0];
  endfunction

  function new(input string name="count_in_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                count_out_reg
/////////////////////////////////////////////////////
class count_out_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(count_out_reg_c)
  rand uvm_reg_field non_reserved_auto_added_field;
  
  covergroup wr_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    non_reserved_auto_added_field = fld_set[0];
  endfunction

  function new(input string name="count_out_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                ctrl_reg
/////////////////////////////////////////////////////
class ctrl_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(ctrl_reg_c)
  rand uvm_reg_field enable;
  rand uvm_reg_field soft_rst;
  
  covergroup wr_fld_covg;
    enable: coverpoint enable.value[0:0];
    soft_rst: coverpoint soft_rst.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    enable: coverpoint enable.value[0:0];
    soft_rst: coverpoint soft_rst.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    enable = fld_set[0];
    soft_rst = fld_set[1];
  endfunction

  function new(input string name="ctrl_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                drop_cfg_reg
/////////////////////////////////////////////////////
class drop_cfg_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(drop_cfg_reg_c)
  rand uvm_reg_field drop_en;
  rand uvm_reg_field drop_opcode;
  
  covergroup wr_fld_covg;
    drop_en: coverpoint drop_en.value[0:0];
    drop_opcode: coverpoint drop_opcode.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    drop_en: coverpoint drop_en.value[0:0];
    drop_opcode: coverpoint drop_opcode.value[3:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    drop_en = fld_set[0];
    drop_opcode = fld_set[1];
  endfunction

  function new(input string name="drop_cfg_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                dropped_count_reg
/////////////////////////////////////////////////////
class dropped_count_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(dropped_count_reg_c)
  rand uvm_reg_field non_reserved_auto_added_field;
  
  covergroup wr_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    non_reserved_auto_added_field: coverpoint non_reserved_auto_added_field.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    non_reserved_auto_added_field = fld_set[0];
  endfunction

  function new(input string name="dropped_count_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                mode_reg
/////////////////////////////////////////////////////
class mode_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(mode_reg_c)
  rand uvm_reg_field mode;
  
  covergroup wr_fld_covg;
    mode: coverpoint mode.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    mode: coverpoint mode.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    mode = fld_set[0];
  endfunction

  function new(input string name="mode_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                params_reg
/////////////////////////////////////////////////////
class params_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(params_reg_c)
  rand uvm_reg_field mask;
  rand uvm_reg_field add_const;
  
  covergroup wr_fld_covg;
    mask: coverpoint mask.value[15:0];
    add_const: coverpoint add_const.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    mask: coverpoint mask.value[15:0];
    add_const: coverpoint add_const.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    mask = fld_set[0];
    add_const = fld_set[1];
  endfunction

  function new(input string name="params_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                status_reg
/////////////////////////////////////////////////////
class status_reg_c extends cdns_uvm_reg;

  `uvm_object_utils(status_reg_c)
  rand uvm_reg_field busy;
  
  covergroup wr_fld_covg;
    busy: coverpoint busy.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    busy: coverpoint busy.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    busy = fld_set[0];
  endfunction

  function new(input string name="status_reg_c");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cpm_cpm_regs
/////////////////////////////////////////////////////
class cpm_regs_c extends cdns_uvm_reg_block;

  `uvm_object_utils(cpm_regs_c)
  rand count_in_reg_c count_in_reg;
  rand count_out_reg_c count_out_reg;
  rand ctrl_reg_c ctrl_reg;
  rand drop_cfg_reg_c drop_cfg_reg;
  rand dropped_count_reg_c dropped_count_reg;
  rand mode_reg_c mode_reg;
  rand params_reg_c params_reg;
  rand status_reg_c status_reg;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config({"cpm_regs", config_path});
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(count_in_reg, reg_set[0]))
      `uvm_error("UVM_REG", "count_in_reg register casting error")
    if(! $cast(count_out_reg, reg_set[1]))
      `uvm_error("UVM_REG", "count_out_reg register casting error")
    if(! $cast(ctrl_reg, reg_set[2]))
      `uvm_error("UVM_REG", "ctrl_reg register casting error")
    if(! $cast(drop_cfg_reg, reg_set[3]))
      `uvm_error("UVM_REG", "drop_cfg_reg register casting error")
    if(! $cast(dropped_count_reg, reg_set[4]))
      `uvm_error("UVM_REG", "dropped_count_reg register casting error")
    if(! $cast(mode_reg, reg_set[5]))
      `uvm_error("UVM_REG", "mode_reg register casting error")
    if(! $cast(params_reg, reg_set[6]))
      `uvm_error("UVM_REG", "params_reg register casting error")
    if(! $cast(status_reg, reg_set[7]))
      `uvm_error("UVM_REG", "status_reg register casting error")

  endfunction

  function new(input string name="cpm_cpm_regs");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                cpm_regs
/////////////////////////////////////////////////////
class cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0 extends cdns_uvm_reg_block;

  `uvm_object_utils(cpm_regs_vendor_Cadence_Design_Systems_library_CPM_Registers_version_1_0)

  uvm_reg_map default_map;
  uvm_reg_map cpm;
  rand cpm_regs_c cpm_cpm_regs;

  virtual function void build();
    cpm = create_map("cpm", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = cpm;
    cpm_cpm_regs = cpm_regs_c::type_id::create("cpm_cpm_regs", , get_full_name());
    cpm_cpm_regs.configure(this);
    cpm_cpm_regs.build();

    //Mapping cpm map
    cpm_cpm_regs.default_map.add_parent_map(cpm,`UVM_REG_ADDR_WIDTH'h0);
    cpm.set_submap_offset(cpm_cpm_regs.default_map, `UVM_REG_ADDR_WIDTH'h0);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="cpm_regs");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


//*************************************************//
//Factory Methods
//*************************************************//
class reg_verifier_factory extends cdns_factory_base;
   virtual function uvm_object create(string typename, string pathname,string objectname);
      case(typename)
         "count_in_reg_c": begin count_in_reg_c count_in_reg = new(objectname); create = count_in_reg;  end
         "count_out_reg_c": begin count_out_reg_c count_out_reg = new(objectname); create = count_out_reg;  end
         "ctrl_reg_c": begin ctrl_reg_c ctrl_reg = new(objectname); create = ctrl_reg;  end
         "drop_cfg_reg_c": begin drop_cfg_reg_c drop_cfg_reg = new(objectname); create = drop_cfg_reg;  end
         "dropped_count_reg_c": begin dropped_count_reg_c dropped_count_reg = new(objectname); create = dropped_count_reg;  end
         "mode_reg_c": begin mode_reg_c mode_reg = new(objectname); create = mode_reg;  end
         "params_reg_c": begin params_reg_c params_reg = new(objectname); create = params_reg;  end
         "status_reg_c": begin status_reg_c status_reg = new(objectname); create = status_reg;  end

      endcase
   endfunction
endclass


//get_factory() function to select the factory
function automatic cdns_factory_base get_factory(bit no_factory);
   static cdns_factory_base factory;
   if(factory == null) begin
      if(no_factory == 1) begin
         reg_verifier_factory rv_factory = new;
         factory = rv_factory;
      end
      else begin
         uvm_factory_proxy rv_factory = new;
         factory = rv_factory;
      end
   end
   cdns_uvmreg_utils_pkg::factory=factory;


   return factory;
endfunction
cdns_factory_base factory = get_factory(no_factory);

endpackage



