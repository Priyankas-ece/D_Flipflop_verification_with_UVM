//======================================================
// File Name   : interface.sv
// Interface   : dff_interface
// Description : Interface for D Flip-Flop DUT
//               - Groups DUT input/output signals
//               - Provides a common connection point
//                 for driver, monitor, and DUT
//======================================================

//------------------------------------------------------
// Interface declaration
//------------------------------------------------------
interface dff_interface(input logic clk); 

  //----------------------------------------------------
  // Signal declarations
  //----------------------------------------------------
  logic rst;   // Reset signal
  logic din;   // Data input
  logic dout;  // Data output

endinterface
