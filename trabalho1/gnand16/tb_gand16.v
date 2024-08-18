//
// Test bench para Gate NAND combinacional de 2 entradas de 16 bits
//
// Dicas:
// https://www.referencedesigner.com/tutorials/verilog/verilog_62.php

// modulos usados
`include "gand16.v"

module tb_gand16;
  
  // inputs
    reg [15:0]in_a;
    reg [15:0]in_b;

  // output
    wire [15:0]out_y;

  // Instancia da UUT (Unit Under Test)
  gand16 uut (.a(in_a), .b(in_b), .y(out_y));

  // Como os sinais irao variar durante a simulacao
  initial begin
    $display("Testbench para gate AND combinacional de 16 bits");
    $dumpfile("signals.vcd");
    $dumpvars(0,tb_gand16);

    // Testes
    # 0 in_a = 16'b0000000000000000; in_b = 16'b0000000000000000;
    # 10 in_a = 16'b0000000000000000; in_b = 16'b0000000000000001;
    # 10 in_a = 16'b0000000000000001; in_b = 16'b0000000000000000;
    # 10 in_a = 16'b0000000000000001; in_b = 16'b0000000000000001;
    # 10 in_a = 16'b0111111111111111; in_b = 16'b0000000000000000;
    # 10 in_a = 16'b0000000000000000; in_b = 16'b0111111111111111;
    # 10 in_a = 16'b0111111111111111; in_b = 16'b0111111111111111;


    # 10 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor("t=%03d: \ta=%d,b=%d,y=%d\n",$time,in_a,in_b,out_y);
  end

endmodule

