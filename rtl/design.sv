//======================================================
// File Name   : design.sv
// Module Name : dff
// Description : RTL design of a D Flip-Flop
//               - Captures input 'din' on clock event
//               - Supports reset functionality
//               - Used as DUT for UVM verification
//======================================================

module dff(
  input clk,  // Clock signal
  input rst,  // Reset signal (active high)
  input din,  // Data input
  output reg dout  // Data output
);
  
  always @(posedge clk or negedge clk ) 
    begin 
      if (rst) 
        begin
          // Reset output to known state
          assign dout = 0;
        end
      
      else 
        begin 
          // Capture input data
          assign dout = din;
        end
    end
  
endmodule