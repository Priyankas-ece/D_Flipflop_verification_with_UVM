//dff UVM tb Test

class dff_test extends uvm_test;
  //factory registeration
  `uvm_component_utils(dff_test);
  
  dff_env env;
  dff_seq seq;
  
  //constructor
  function new(string name = "dff_test",uvm_component parent);
    super.new(name,parent);
    `uvm_info("dff_test","constructor",UVM_NONE);
  endfunction
  
  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dff_env::type_id::create("env",this);
    seq = dff_seq::type_id::create("seq",this);
  endfunction
  
  //Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("dff_test","connect phase",UVM_NONE);
  endfunction 
  
  //Run phase
  task run_phase(uvm_phase phase);
    `uvm_info("dff_test","run phase",UVM_NONE);
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
  
endclass