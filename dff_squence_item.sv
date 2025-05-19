//dff UVM tb Squence_item

class dff_seq_item extends uvm_sequence_item; 
  
  //factory registeration 
  `uvm_object_utils(dff_seq_item)
  
  //signal declaration
  rand logic rst;
  rand logic din;
  logic dout;
  
  //constructor 
  function new(string name = "dff_seq_item");
    super.new(name);
    `uvm_info("dff_seq_item","constructor", UVM_NONE)
  endfunction 
  
endclass