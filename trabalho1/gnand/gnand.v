//
// Gate NAND combinacional
//
module gnand(input a, input b, output y);
  
  assign y = ~(a & b);

endmodule

