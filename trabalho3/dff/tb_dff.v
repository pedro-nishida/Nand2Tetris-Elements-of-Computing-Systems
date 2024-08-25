`include "dff.v"

module tb_dff;

  // Sinais de entrada
  reg in_d;
  reg in_clk;
  reg in_rst;
  
  // Sinais de saída
  wire out_q;
  wire out_qn;

  // Instancia da UUT (Unit Under Test)
  dff uut (
    .d(in_d), 
    .clk(in_clk), 
    .rst(in_rst), 
    .q(out_q), 
    .qn(out_qn)
  );

  // Inicializa os sinais
  initial begin
    in_clk = 0;
    in_rst = 0;
    in_d = 0;
  end

  // Como os sinais irão variar durante a simulação
  initial begin
    $display("DFF");
    $dumpfile("signals.vcd");
    $dumpvars(0, tb_dff);

    // Test cases
    #2 in_rst = 1; // Reset ativo
    #2 in_rst = 0; // Reset desativado

    // Padrões fornecidos
    #2 in_d = 1; // xxx01
    #2 in_d = 0;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 1; // 1xx01
    #2 in_d = 0;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0xx01
    #2 in_d = 0;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0x001
    #2 in_d = 0;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0x101
    #2 in_d = 1;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0x001
    #2 in_d = 0;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0x101
    #2 in_d = 1;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 1; // 1x101
    #2 in_d = 1;
    #2 in_d = 0;
    #2 in_d = 1;

    #2 in_d = 0; // 0x101
    #2 in_d = 1;
    #2 in_d = 0;
    #2 in_d = 1;

    #20 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor("t=%03d: \tin_rst=%d, in_clk=%d, in_d=%d, out_q=%d, out_qn=%d \n", $time, in_rst, in_clk, in_d, out_q, out_qn);
  end

  // Gerador de clock com bloco always de única linha
  always 
    #1 in_clk = ~in_clk;

endmodule