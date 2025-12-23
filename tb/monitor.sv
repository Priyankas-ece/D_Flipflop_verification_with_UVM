//======================================================
// File Name   : monitor.sv
// Class Name  : dff_monitor
// Description : UVM Monitor for D Flip-Flop verification
//               - Observes DUT signals via interface
//               - Captures input and output transactions
//               - Sends collected data to scoreboard
//======================================================

class dff_monitor extends uvm_monitor;

  //----------------------------------------------------
  // Factory registration for monitor
  //----------------------------------------------------
  `uvm_component_utils(dff_monitor)

  //----------------------------------------------------
  // Virtual interface handle
  //----------------------------------------------------
  virtual dff_interface intf;

  //----------------------------------------------------
  // Analysis port to send collected transactions
  //----------------------------------------------------
  uvm_analysis_port #(dff_seq_item) item_collected_port;

  //----------------------------------------------------
  // Sequence item handle for sampled data
  //----------------------------------------------------
  dff_seq_item seq_item_h;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR", "dff_monitor constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Initializes analysis port and retrieves interface
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    item_collected_port = new("item_collected_port", this);

    // Retrieve virtual interface from configuration DB
    if (!uvm_config_db#(virtual dff_interface)::get(this, "", "vif", intf))
      `uvm_fatal("NO_VIRTUAL_INTERFACE",
                 "Virtual interface not set for dff_monitor")

    `uvm_info("MONITOR",
              "Virtual interface successfully retrieved",
              UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Run phase
  // Samples DUT signals on clock activity
  //----------------------------------------------------
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge intf.clk or negedge intf.clk);

      // Create a new transaction for each sample
      seq_item_h = dff_seq_item::type_id::create("seq_item_h");

      // Capture interface signals
      seq_item_h.rst  = intf.rst;
      seq_item_h.din  = intf.din;
      seq_item_h.dout = intf.dout;

      // Send collected transaction to scoreboard
      item_collected_port.write(seq_item_h);

      $display("[MONITOR] Time=%0t | rst=%b din=%b dout=%b",
                $time, intf.rst, intf.din, intf.dout);
    end
  endtask

endclass
