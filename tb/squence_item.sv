//======================================================
// File Name   : sequence_item.sv
// Class Name  : dff_seq_item
// Description : UVM Sequence Item (Transaction) for DFF
//               - Represents stimulus and response data
//               - Used by sequence, driver, monitor, and
//                 scoreboard
//======================================================

class dff_seq_item extends uvm_sequence_item; 
  
  //----------------------------------------------------
  // Factory registration for sequence item
  //----------------------------------------------------
  `uvm_object_utils(dff_seq_item)
  
  //----------------------------------------------------
  // Signal declarations
  //----------------------------------------------------
  rand logic rst;   // Reset stimulus
  rand logic din;   // Data input stimulus
  logic      dout;  // Observed output from DUT
  
  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_seq_item");
    super.new(name);
    `uvm_info("SEQ_ITEM",
              "dff_seq_item constructor called",
              UVM_LOW)
  endfunction 
  
endclass
