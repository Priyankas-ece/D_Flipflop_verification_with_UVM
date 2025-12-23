//======================================================
// File Name   : scoreboard.sv
// Class Name  : dff_scoreboard
// Description : UVM Scoreboard for D Flip-Flop verification
//               - Receives transactions from monitor
//               - Compares expected vs actual output
//               - Reports mismatches and errors
//======================================================

class dff_scoreboard extends uvm_scoreboard;

  //----------------------------------------------------
  // Factory registration for scoreboard
  //----------------------------------------------------
  `uvm_component_utils(dff_scoreboard)

  //----------------------------------------------------
  // Analysis export to receive monitored transactions
  //----------------------------------------------------
  uvm_analysis_imp#(dff_seq_item, dff_scoreboard) item_collected_export;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCOREBOARD", "dff_scoreboard constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Creates analysis export
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    item_collected_export = new("item_collected_export", this);

    `uvm_info("SCOREBOARD",
              "Analysis export created",
              UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Write method
  // Performs data checking for each transaction
  //----------------------------------------------------
  function void write(dff_seq_item seq_item_h);

    // Case 1: Reset deasserted → dout should match din
    if (seq_item_h.rst == 0) begin
      if (seq_item_h.dout !== seq_item_h.din) begin
        $error("SCOREBOARD ERROR: Data mismatch | din=%b dout=%b time=%0t",
               seq_item_h.din, seq_item_h.dout, $time);
      end
      else begin
        `uvm_info("SCOREBOARD",
                  $sformatf("PASS: din=%b matches dout=%b",
                            seq_item_h.din, seq_item_h.dout),
                  UVM_LOW)
      end
    end
    // Case 2: Reset asserted → dout should be 0
    else begin
      if (seq_item_h.dout !== 0) begin
        $error("SCOREBOARD ERROR: dout != 0 during reset | din=%b dout=%b time=%0t",
               seq_item_h.din, seq_item_h.dout, $time);
      end
      else begin
        `uvm_info("SCOREBOARD",
                  "PASS: dout is 0 during reset",
                  UVM_LOW)
      end
    end

  endfunction

endclass
