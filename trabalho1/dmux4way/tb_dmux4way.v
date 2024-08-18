`include "dmux4way.v"

module tb_dmux4way;
  
  // inputs
  reg [3:0]in_entrada;
  reg [1:0]in_sel;
  // outputs
  wire out_o0;
  wire out_o1;
  wire out_o2;
  wire out_o3;

  // Instancia da UUT (Unit Under Test)
  dmux4way uut (
    .entrada(in_entrada), 
    .sel(in_sel), 
    .o0(out_o0), 
    .o1(out_o1),
    .o2(out_o2),
    .o3(out_o3)
    );

  // Como os sinais irao variar durante a simulacao
  initial begin
    $display("Testbench para Demultiplexador de duas entradas 4 way");
    $dumpfile("signals.vcd");
    $dumpvars(0,tb_dmux4way);

    # 0 in_entrada = 4'b0001; in_sel = 2'b00; 
    # 10 in_entrada = 4'b0001; in_sel = 2'b01;
    # 10 in_entrada = 4'b0001; in_sel = 2'b10; 
    # 10 in_entrada = 4'b0001; in_sel = 2'b11;



    # 10 $finish;
  end

  // Monitora os sinais
  initial begin
    $monitor(
        "t=%03d: \tentrada=%d,sel=%d,o0=%d,o1=%d,o2=%d,o3=%d \n",
        $time,in_entrada,in_sel,out_o0,out_o1,out_o2,out_o3);
  end

endmodule
