//======================================================
// File Name   : driver.sv
// Class Name  : dff_driver
// Description : UVM Driver for D Flip-Flop verification
//               - Receives sequence items from sequencer
//               - Drives DUT signals through interface
//======================================================

class dff_driver extends uvm_driver#(dff_seq_item);

  //----------------------------------------------------
  // Factory registration for driver
  //----------------------------------------------------
  `uvm_component_utils(dff_driver)

  //----------------------------------------------------
  // Virtual interface handle
  //----------------------------------------------------
  virtual dff_interface intf;

  //----------------------------------------------------
  // Sequence item handle
  //----------------------------------------------------
  dff_seq_item seq_item_h;

  //----------------------------------------------------
  // Constructor
  //----------------------------------------------------
  function new(string name = "dff_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("DRIVER", "dff_driver constructor called", UVM_LOW)
  endfunction

  //----------------------------------------------------
  // Build phase
  // Retrieves virtual interface from config DB
  //----------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual dff_interface)::get(this, "", "vif", intf)) begin
      `uvm_fatal("NO_VIRTUAL_INTERFACE",
                 "Virtual interface is not set for dff_driver")
    end

    `uvm_info("DRIVER",
              "Virtual interface successfully retrieved",
              UVM_MEDIUM)
  endfunction

  //----------------------------------------------------
  // Run phase
  // Fetches sequence items and drives them to DUT
  //----------------------------------------------------
  task run_phase(uvm_phase phase);
    forever begin
      `uvm_info("DRIVER", "Waiting for next sequence item", UVM_LOW)

      seq_item_port.get_next_item(seq_item_h);

      `uvm_info("DRIVER",
                $sformatf("Driving transaction: rst=%b din=%b",
                          seq_item_h.rst, seq_item_h.din),
                UVM_MEDIUM)

      drive();

      seq_item_port.item_done();
    end
  endtask

  //----------------------------------------------------
  // Drive task
  // Applies stimulus on positive edge of clock
  //----------------------------------------------------
  task drive();
    @(posedge intf.clk)

    intf.rst <= seq_item_h.rst;
    intf.din <= seq_item_h.din;

    $display("[DRIVER] Time=%0t | Applied rst=%b din=%b",
              $time, seq_item_h.rst, seq_item_h.din);
  endtask  

endclass
