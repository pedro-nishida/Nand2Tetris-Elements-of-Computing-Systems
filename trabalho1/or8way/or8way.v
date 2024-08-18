//
// Gate OR de 8 entradas
//
module or8way(input [7:0]a, output y);

  assign y = a[0] | a[1] | a[2] | a[3] | a[4] | a[5] | a[6] | a[7];

endmodule