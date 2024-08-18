//
//  Gate DMUX combinacional para saida de 1 bit
//
module dmux(input a, input sel, output y0, output y1);
  
    assign y0 = sel ? 1'b0 : a;
    assign y1 = sel ? a : 1'b0;
    
endmodule