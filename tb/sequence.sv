//======================================================
// File Name   : sequence.sv
// Class Name  : dff_seq
// Description : UVM Sequence for D Flip-Flop verification
//               - Generates randomized stimulus
//               - Sends sequence items to sequencer
//======================================================

class dff_seq extends uvm_sequence #(dff_seq_item);
  
  //----------------------------------------------------
  // Factory registration for sequence
  //----------------------------------------------------
  `uvm_object_utils(dff_seq)
  
  //----------------------------------------------------
  // Sequence item handle
  //----------------------------------------------------
  dff_seq_item seq_item_h;
  
  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_seq");
    super.new(name);
    `uvm_info("SEQUENCE", "dff_seq constructor called", UVM_LOW)
  endfunction
  
  //----------------------------------------------------
  // Body task
  // Generates and sends transactions to sequencer
  //----------------------------------------------------
  task body();
    `uvm_info("SEQUENCE",
              "Starting DFF stimulus sequence",
              UVM_LOW)

    repeat (20) begin
      // Create a new sequence item
      seq_item_h = dff_seq_item::type_id::create("seq_item_h", null);

      // Start the item
      start_item(seq_item_h);

      // Apply stimulus
      seq_item_h.rst = 0;
      seq_item_h.din = $urandom();

      `uvm_info("SEQUENCE",
                $sformatf("Generated item: rst=%b din=%b",
                          seq_item_h.rst, seq_item_h.din),
                UVM_MEDIUM)

      // Finish the item
      finish_item(seq_item_h);
    end

    `uvm_info("SEQUENCE",
              "DFF stimulus sequence completed",
              UVM_LOW)
  endtask
  
endclass
