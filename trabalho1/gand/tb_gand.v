//
// Test bench para Gate NAND combinacional
//
// Dicas:
// https://www.referencedesigner.com/tutorials/verilog/verilog_62.php

// modulos usados
`include "gand.v"

module tb_gand;
  
  // inputs
  reg in_a;
  reg in_b;
  // outputs
  wire out_y;

  // Instancia da UUT (Unit Under Test)
  gand uut (.a(in_a), .b(in_b), .y(out_y));

  // Como os sinais irao variar durante a simulacao
  initial begin
    $display("Testbench para gate NAND combinacional");
    $dumpfile("signals.vcd");
    $dumpvars(0,tb_gand);

    # 0 in_a = 0; in_b = 0;
    # 10 in_a = 0; in_b = 1;
    # 10 in_a = 1; in_b = 0;
    # 10 in_a = 1; in_b = 1;

    # 10 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor("t=%03d: \ta=%d,b=%d,y=%d\n",$time,in_a,in_b,out_y);
  end

endmodule

