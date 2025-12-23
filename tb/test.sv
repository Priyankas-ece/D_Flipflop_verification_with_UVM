//======================================================
// File Name   : test.sv
// Class Name  : dff_test
// Description : UVM Test for D Flip-Flop verification
//               - Instantiates the environment
//               - Starts the stimulus sequence
//               - Controls simulation flow using objections
//======================================================

class dff_test extends uvm_test;

  //----------------------------------------------------
  // Factory registration for test
  //----------------------------------------------------
  `uvm_component_utils(dff_test)

  //----------------------------------------------------
  // Environment and sequence handles
  //----------------------------------------------------
  dff_env env;
  dff_seq seq;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST", "dff_test constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Creates environment and sequence
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = dff_env::type_id::create("env", this);
    seq = dff_seq::type_id::create("seq", this);

    `uvm_info("TEST",
              "Environment and sequence created",
              UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Connect phase
  //----------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST", "Connect phase completed", UVM_LOW)
  endfunction 

  //----------------------------------------------------
  // Run phase
  // Starts the sequence and manages objections
  //----------------------------------------------------
  task run_phase(uvm_phase phase);
    `uvm_info("TEST", "Run phase started", UVM_LOW)

    phase.raise_objection(this);

    `uvm_info("TEST",
              "Starting DFF stimulus sequence",
              UVM_MEDIUM)

    seq.start(env.agent.seqr);

    `uvm_info("TEST",
              "Sequence completed, dropping objection",
              UVM_MEDIUM)

    phase.drop_objection(this);
  endtask

endclass
