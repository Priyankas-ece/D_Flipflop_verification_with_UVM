//======================================================
// File Name   : sequencer.sv
// Class Name  : dff_seqr
// Description : UVM Sequencer for D Flip-Flop verification
//               - Controls the flow of sequence items
//               - Acts as an arbitrator between sequence
//                 and driver
//======================================================

class dff_seqr extends uvm_sequencer#(dff_seq_item);

  //----------------------------------------------------
  // Factory registration for sequencer
  //----------------------------------------------------
  `uvm_component_utils(dff_seqr)

  //----------------------------------------------------
  // Handle for sequence
  //----------------------------------------------------
  dff_seq seq_h;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SEQUENCER", "dff_seqr constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Creates sequence instance using factory
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seq_h = dff_seq::type_id::create("seq_h");

    `uvm_info("SEQUENCER",
              "Sequence handle created in build_phase",
              UVM_MEDIUM)
  endfunction

endclass
