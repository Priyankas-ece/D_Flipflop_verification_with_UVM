//======================================================
// File Name   : agent.sv
// Class Name  : dff_agent
// Description : UVM Agent for D Flip-Flop verification
//               - Encapsulates driver, sequencer, monitor
//               - Supports active and passive modes
//======================================================

class dff_agent extends uvm_agent;

  //----------------------------------------------------
  // Factory registration for agent
  //----------------------------------------------------
  `uvm_component_utils(dff_agent)

  //----------------------------------------------------
  // Agent sub-components
  //----------------------------------------------------
  dff_driver  driver;
  dff_seqr    seqr;
  dff_monitor monitor;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("AGENT", "dff_agent constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Creates driver, sequencer, and monitor
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (get_is_active == UVM_ACTIVE) begin
      driver = dff_driver::type_id::create("driver", this);
      seqr   = dff_seqr::type_id::create("seqr", this);

      `uvm_info("AGENT",
                "Active agent: Driver and Sequencer created",
                UVM_MEDIUM)
    end

    monitor = dff_monitor::type_id::create("monitor", this);

    `uvm_info("AGENT", "Monitor created", UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Connect phase
  // Connects driver and sequencer ports
  //----------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info("AGENT", "Connect phase started", UVM_LOW)

    if (get_is_active === UVM_ACTIVE) begin
      driver.seq_item_port.connect(seqr.seq_item_export);

      `uvm_info("AGENT",
                "Driver and Sequencer connected",
                UVM_MEDIUM)
    end
  endfunction

endclass
