//dff UVM tb Agent

class dff_agent extends uvm_agent;
  //factory registeration
  `uvm_component_utils(dff_agent)
  
  dff_driver driver;
  dff_seqr seqr;
  dff_monitor monitor;
  
  //constructor 
  function new(string name = "dff_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("dff_agent", "Constructor", UVM_NONE);
  endfunction
  
  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active==UVM_ACTIVE)begin
      driver  = dff_driver::type_id::create("driver", this);
      seqr    = dff_seqr::type_id::create("seqr", this);
    end
    monitor = dff_monitor::type_id::create("monitor", this);
  endfunction
  
  //Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("dff_agent", "Connect Phase", UVM_NONE);
    if(get_is_active===UVM_ACTIVE)begin
      driver.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
  
endclass