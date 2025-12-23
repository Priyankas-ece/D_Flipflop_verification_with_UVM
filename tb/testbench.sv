//======================================================
// File Name   : testbench.sv
// Module Name : dff_top_tb
// Description : Top-level UVM testbench for D Flip-Flop
//               - Instantiates DUT
//               - Connects interface
//               - Configures UVM environment
//               - Generates clock and stimulus
//======================================================

//------------------------------------------------------
// Include UVM macros and import UVM package
//------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;

//------------------------------------------------------
// Include testbench component files
//------------------------------------------------------
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

//------------------------------------------------------
// Top-level testbench module
//------------------------------------------------------
module dff_top_tb;

  logic clk;   // Clock signal

  //----------------------------------------------------
  // Interface instantiation
  //----------------------------------------------------
  dff_interface intf(.clk(clk));

  //----------------------------------------------------
  // DUT instantiation and connection
  //----------------------------------------------------
  dff dff_inst (
    .clk  (intf.clk),
    .rst  (intf.rst),
    .din  (intf.din),
    .dout (intf.dout)
  );

  //----------------------------------------------------
  // UVM virtual interface configuration
  //----------------------------------------------------
  initial begin
    uvm_config_db#(virtual dff_interface)::set(null, "*", "vif", intf);
    `uvm_info("TB", "Virtual interface set in UVM config DB", UVM_LOW)
  end

  //----------------------------------------------------
  // Clock generation (20 time unit period)
  //----------------------------------------------------
  always #10 clk = ~clk;

  //----------------------------------------------------
  // Initial stimulus block
  //----------------------------------------------------
  initial begin
    `uvm_info("TB", "Starting initial stimulus", UVM_LOW)

    clk      = 1;
    intf.rst = 1;
    intf.din = 1111;

    `uvm_info("TB", "Reset asserted and initial data applied", UVM_MEDIUM)

    #20 intf.rst = 0;
    `uvm_info("TB", "Reset deasserted", UVM_MEDIUM)

    repeat (20) begin
      #10 intf.din = $urandom_range(0,1);
      $display("[TB STIM] Time=%0t | Random din applied = %b", $time, intf.din);
    end

    `uvm_info("TB", "Stimulus completed, ending simulation", UVM_LOW)
    #500 $finish;
  end  

  //----------------------------------------------------
  // Monitor input and output signals
  //----------------------------------------------------
  initial begin
    $monitor("[TB MON] Time=%0t | clk=%b rst=%b din=%b dout=%b",
              $time, clk, intf.rst, intf.din, intf.dout);
  end

  //----------------------------------------------------
  // Start UVM test
  //----------------------------------------------------
  initial begin 
    `uvm_info("TB", "Starting UVM test: dff_test", UVM_LOW)
    run_test("dff_test");
  end

  //----------------------------------------------------
  // Dump waveform for debugging
  //----------------------------------------------------
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1, dff_top_tb);
    `uvm_info("TB", "Waveform dumping enabled", UVM_LOW)
  end

endmodule