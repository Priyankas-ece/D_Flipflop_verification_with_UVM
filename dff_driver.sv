//dff uvm tb driver

class dff_driver extends uvm_driver#(dff_seq_item);
  //factory registeration
  `uvm_component_utils(dff_driver)
  
  //Virtual Interface
  virtual dff_interface intf;
  
  dff_seq_item seq_item_h;
  
  //constructor
  function new(string name = "dff_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("dff_driver", "constructor", UVM_NONE)
  endfunction
   
  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dff_interface)::get(this,"", "vif", intf))begin
      `uvm_fatal("NO_VIRTUAL_INTERFACE","Virtual interface is not set for dff_driver");
    end
  endfunction
  
  //Run phase
  task run_phase(uvm_phase phase);
    forever begin
      `uvm_info("dff_driver","run_phase", UVM_NONE)
      seq_item_port.get_next_item(seq_item_h);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  //Driver
  task drive();
    @(posedge intf.clk)
    intf.rst <= seq_item_h.rst;
    intf.din <= seq_item_h.din;
  endtask  
  
endclass