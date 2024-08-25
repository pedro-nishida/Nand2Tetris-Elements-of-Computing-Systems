// Sflip flop tipo D

module dff(input d, input clk, input rst, output reg q, output qn);
  
  initial q <= 0;
  assign qn = ~q;

  always @ ( posedge clk or posedge rst ) begin
    if(rst == 1) 
      q <= 0;
    else 
      q <= d;
    
  end

endmodule

