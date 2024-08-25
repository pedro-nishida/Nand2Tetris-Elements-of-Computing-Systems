`include "pc.v"

module tb_pc;

  // Sinais de entrada
  reg [15:0] in_in;
  reg in_load;
  reg in_inc;
  reg in_reset;
  reg in_clk;
  
  // Sinais de saída
  wire [15:0] out;

  // Instancia da UUT (Unit Under Test)
  pc uut (
    .in(in_in), 
    .load(in_load), 
    .inc(in_inc), 
    .reset(in_reset), 
    .out(out), 
    .clk(in_clk)
  );

  // Inicializa os sinais
  initial begin
    in_clk = 0;
    in_reset = 0;
    in_load = 0;
    in_inc = 0;
    in_in = 0;
  end

  // Como os sinais irão variar durante a simulação
  initial begin
    $display("PC Testbench");
    $dumpfile("tb_pc.vcd");
    $dumpvars(0, tb_pc);

    // Test cases
    #5 in_reset = 1; // Ativa o reset
    #5 in_reset = 0; // Desativa o reset

    // Teste de carregamento
    #5 in_in = 16'hA5A5; in_load = 1; in_inc = 0;
    #5 in_load = 0;

    // Teste de incremento
    #5 in_inc = 1;
    #5 in_inc = 0;

    // Teste de reset durante incremento
    #5 in_inc = 1; in_reset = 1;
    #5 in_reset = 0; in_inc = 0;

    // Teste de carregamento durante incremento
    #5 in_in = 16'h5A5A; in_load = 1; in_inc = 1;
    #5 in_load = 0; in_inc = 0;

    // Teste aleatório
    for (integer i = 0; i < 40; i = i + 1) begin
        #2 in_in = $random; in_inc = $random; in_load = !in_inc; in_clk = 1;
        #2 in_clk = 0;
    end

    #20 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor("t=%03d: \tin_reset=%d, in_clk=%d, in_load=%d, in_inc=%d, in_in=%h, out=%h \n", $time, in_reset, in_clk, in_load, in_inc, in_in, out);
  end

  // Gerador de clock com bloco always de única linha
  always 
    #1 in_clk = ~in_clk;

endmodule