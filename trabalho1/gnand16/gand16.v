//
// Gate NAND combinacional de 2 entrada de 16 bits
//
module gand16(input[15:0]a, input[15:0]b, output[15:0]y);
  
  assign y = a & b;

endmodule

