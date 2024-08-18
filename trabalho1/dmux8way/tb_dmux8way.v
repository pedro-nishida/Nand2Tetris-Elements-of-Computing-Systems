`include "dmux8way.v"

module tb_dmux8way;
  reg [7:0] in_entrada;
  reg [2:0] in_sel;
  wire out_o0, out_o1, out_o2, out_o3, out_o4, out_o5, out_o6, out_o7;

  dmux8way uut (
    .entrada(in_entrada), 
    .sel(in_sel), 
    .o0(out_o0), 
    .o1(out_o1),
    .o2(out_o2),
    .o3(out_o3),
    .o4(out_o4),
    .o5(out_o5),
    .o6(out_o6),
    .o7(out_o7)
    );

  initial begin
    $display("Testbench para Demultiplexador de 8 saídas");
    $dumpfile("signals.vcd");
    $dumpvars(0, tb_dmux8way);

    #0 in_entrada = 8'b00000001; in_sel = 3'b000;
    #10 in_entrada = 8'b00000001; in_sel = 3'b001;
    #10 in_entrada = 8'b00000001; in_sel = 3'b010;
    #10 in_entrada = 8'b00000001; in_sel = 3'b011;
    #10 in_entrada = 8'b00000001; in_sel = 3'b100;
    #10 in_entrada = 8'b00000001; in_sel = 3'b101;
    #10 in_entrada = 8'b00000001; in_sel = 3'b110;
    #10 in_entrada = 8'b00000001; in_sel = 3'b111;
    #10 $finish;
  end

  initial $monitor("entrada=%b sel=%b -> o0=%b o1=%b o2=%b o3=%b o4=%b o5=%b o6=%b o7=%b", in_entrada, in_sel, out_o0, out_o1, out_o2, out_o3, out_o4, out_o5, out_o6, out_o7);
endmodule