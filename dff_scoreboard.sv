//dff UVM tb Scoreboard

class dff_scoreboard extends uvm_scoreboard;
  //factory registeration
  `uvm_component_utils(dff_scoreboard);
  
  uvm_analysis_imp#(dff_seq_item,dff_scoreboard) item_collected_export;
  
  //constructor
  function new(string name="dff_scoreboard",uvm_component parent);
    super.new(name,parent);
    `uvm_info("dff_scoreboard","constructor",UVM_NONE)
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export=new("item_collected_export",this);
  endfunction
  
  //Write function
  function void write(dff_seq_item seq_item_h);
    if(seq_item_h.rst == 0)begin
      if(seq_item_h.dout !== seq_item_h.din) begin
        $error("ERROR(mismatch of input and output): din: %b dout: %b at time: %t", seq_item_h.din, seq_item_h.dout, $time);
      end
    end
    else begin
      if(seq_item_h.dout !== 0) begin
        $error("ERROR(dout!=0 @rst=1): din: %b dout: %b at time: %t", seq_item_h.din, seq_item_h.dout, $time);
      end
    end
    
  endfunction
  
endclass