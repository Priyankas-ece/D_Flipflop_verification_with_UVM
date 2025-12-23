//======================================================
// File Name   : environment.sv
// Class Name  : dff_env
// Description : UVM Environment for D Flip-Flop verification
//               - Instantiates agent and scoreboard
//               - Connects monitor analysis port to scoreboard
//======================================================

class dff_env extends uvm_env;

  //----------------------------------------------------
  // Factory registration for environment
  //----------------------------------------------------
  `uvm_component_utils(dff_env)
  
  //----------------------------------------------------
  // Environment components
  //----------------------------------------------------
  dff_scoreboard scoreboard;
  dff_agent      agent;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_environment", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV", "dff_env constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Creates agent and scoreboard components
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    `uvm_info("ENV", "Build phase started", UVM_LOW)
    super.build_phase(phase);

    scoreboard = dff_scoreboard::type_id::create("scoreboard", this);
    agent      = dff_agent::type_id::create("agent", this);

    `uvm_info("ENV",
              "Agent and Scoreboard created",
              UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Connect phase
  // Connects monitor to scoreboard
  //----------------------------------------------------
  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("ENV", "Connect phase started", UVM_LOW)
    super.connect_phase(phase);

    agent.monitor.item_collected_port.connect(
      scoreboard.item_collected_export
    );

    `uvm_info("ENV",
              "Monitor connected to Scoreboard",
              UVM_MEDIUM)
  endfunction
  
endclass
