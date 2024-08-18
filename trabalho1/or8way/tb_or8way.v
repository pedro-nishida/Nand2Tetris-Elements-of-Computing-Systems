//
// Test Bench para Gate OR de 8 entradas
//

// modulos usados
`include "or8way.v"

module tb_or8way;

  reg [7:0] a;
  wire y;

or8way uut (
  .a(a),
  .y(y)
);

initial begin
  $display("Testbench para Gate OR de 8 entradas");
  $dumpfile("signals.vcd");
  $dumpvars(0, tb_or8way);

  a = 8'b00000000;
  #10 a = 8'b00000001;
  #10 a = 8'b10101010;
  #10 a = 8'b11111111;

  #10 $finish;
end

initial begin
  $monitor("t=%03d: \ta=%b,y=%b\n", $time, a, y);
end

endmodule