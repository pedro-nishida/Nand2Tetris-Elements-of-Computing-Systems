//
// Porta NOT de 16 bits
//
module gnot16(input [15:0]a, output [15:0]y);
  
  assign y = ~a;

endmodule