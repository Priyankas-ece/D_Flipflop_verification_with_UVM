//dff uvm tb Sequencer

class dff_seqr extends uvm_sequencer#(dff_seq_item);
  
  //factory registration
  `uvm_component_utils(dff_seqr)
  
  dff_seq seq_h;
  
  //constructor
  function new(string name = "dff_sequencer",uvm_component parent);
    super.new(name,parent);
    `uvm_info("dff_sequencer","constructor",UVM_NONE)
  endfunction
  
  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_h = dff_seq::type_id::create("seq_h");
  endfunction
  
endclass