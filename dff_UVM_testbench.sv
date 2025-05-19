//Testbench code of Dff using uvm

//Including UVM package
`include "uvm_macros.svh"
import uvm_pkg::*;

//Including Files
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

//module declaration
module dff_top_tb;
  logic clk;
  
//Interface creation
  dff_interface intf(.clk(clk));

//Connecting the DUT 
  dff dff_inst (.clk (intf.clk), .rst (intf.rst), .din (intf.din), .dout(intf.dout));

//Connecting virtual interface 
  initial begin
    uvm_config_db#(virtual dff_interface)::set(null,"*","vif",intf);
  end

  //Clock pulse generation
  always #10 clk = ~clk;

  //Stimulation
  initial begin
    clk = 1;
    intf.rst = 1;
    intf.din = 1111;
    #20 intf.rst = 0;
    repeat (20) begin
      #10 intf.din = $urandom_range(0,1); 
    end
    #500 $finish;
  end  

  //Monitoring input and output
  initial begin
    $monitor($time, " - clk = %b, rst = %b, din = %b, dout = %b", clk, intf.rst, intf.din, intf.dout);
  end
  
  //Running the test
  initial begin 
    run_test("dff_test");
  end

  //Dumping waveform
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1,dff_top_tb);
  end
endmodule