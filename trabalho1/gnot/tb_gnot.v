`include "gnot.v"

module tb_gnot;

    //inputs
    reg in_a;

    //outputs
    wire out_y;

    //instanciando da UTT (Unit Under Test)
    gnot uut(.a(in_a), .y(out_y));

    //gerando os estímulos
    initial begin
        // "macros do verilog"
        $display("Testbench para o gate NOT combinacional de 1 bit");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_gnot);
    
        // no instante 0 da minha situação instancie in_a e in_b com 0
        # 0 in_a = 0;
        # 10 in_a = 1;

        # 10 $finish;
    end

    //monitorando os sinais
    initial begin
        $monitor("t=%0t in_a=%b out_y=%b", $time, in_a, out_y);
    end
endmodule