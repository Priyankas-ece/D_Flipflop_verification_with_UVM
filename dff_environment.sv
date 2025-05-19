//dff UVM tb Environment

class dff_env extends uvm_env;
  //factory registeration
  `uvm_component_utils(dff_env)
  
  dff_scoreboard scoreboard;
  dff_agent agent;

  //constructor
  function new(string name = "dff_environment", uvm_component parent);
    super.new(name, parent);
    `uvm_info("dff_environment","Constructor", UVM_NONE)
  endfunction

  //Build phase
  function void build_phase(uvm_phase phase);
    `uvm_info("dff_environment","Build phase", UVM_NONE)
    super.build_phase(phase);
    scoreboard = dff_scoreboard::type_id::create("scoreboard", this);
    agent = dff_agent::type_id::create("agent", this);
  endfunction

  //Connect phase
  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("dff_environment","Connect phase", UVM_NONE)
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
  endfunction
  
endclass