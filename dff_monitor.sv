//dff uvm tb monitor

class dff_monitor extends uvm_monitor;
  //factory registeration
  `uvm_component_utils(dff_monitor)
  
  //Virtual Interface
  virtual dff_interface intf;
  
  //Analysis Port
  uvm_analysis_port #(dff_seq_item) item_collected_port;
  
  dff_seq_item seq_item_h;

   //constructor
  function new(string name = "dff_monitor",uvm_component parent);
     super.new(name,parent);
    `uvm_info("dff_monitor", "constructor", UVM_NONE)
  endfunction
  
  //Build phase
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      item_collected_port = new("item_collected_port", this);
    
    //Virtual interface
    if(!uvm_config_db#(virtual dff_interface)::get(this,"", "vif", intf))
      `uvm_fatal("NO_VIRTUAL_INTERFACE","virtual interface is failed to connect to monitor");
  endfunction
  
  //Run phase
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge intf.clk or negedge intf.clk);
      seq_item_h=dff_seq_item::type_id::create("seq_item_h");
      seq_item_h.rst=intf.rst;
      seq_item_h.din=intf.din;
      seq_item_h.dout=intf.dout;
      item_collected_port.write(seq_item_h);
    end
  endtask

endclass