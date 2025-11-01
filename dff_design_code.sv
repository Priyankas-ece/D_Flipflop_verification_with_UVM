//Design code for Dff

module dff(
  input clk,
  input rst,
  input din,
  output reg dout
);
  
  always @(posedge clk or negedge clk ) 
    begin 
      if (rst) 
        begin
          assign dout = 0;
        end
      else 
        begin 
          assign dout = din;
        end
    end
endmodule
