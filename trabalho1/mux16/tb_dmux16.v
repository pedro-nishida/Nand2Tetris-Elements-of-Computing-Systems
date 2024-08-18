`include "dmux16.v"

module tb_dmux16;
  
  // Entradas de 16 bits
  reg [15:0] in_a;
  reg [15:0] in_b;
  reg in_sel;

  // Saidas de 16 bits
  wire [15:0] out_y;

  // Instancia da UUT (Unit Under Test)
  dmux16 uut (.a(in_a), .b(in_b), .sel(in_sel), .y(out_y));

  // Como os sinais irao variar durante a simulacao
  initial begin
    $display("Testbench para Demultiplexador de duas entradas de 16 bits");
    $dumpfile("signals.vcd");
    $dumpvars(0,tb_dmux16);

    // testes
    # 0 in_a = $random; in_b = $random; in_sel = 0;
    # 10 in_a = $random; in_b = $random; in_sel = 1;
    # 10 in_a = $random; in_b = $random; in_sel = 0;
    # 10 in_a = $random; in_b = $random; in_sel = 1;

    # 10 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor("t=%03d: \ta=%d, b=%d, y=%d\n", $time, in_a, in_b, out_y);
  end

endmodule