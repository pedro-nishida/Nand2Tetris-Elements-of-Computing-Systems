//
// Testbench para MUX de 2 entradas
//

// modulos usados
`include "mux.v"

module tb_mux;
    // Entradas
    reg in_a;
    reg in_b;
    reg in_sel;
    
    // Saída
    wire out_y;

    // Instância do MUX
    mux uut (.a(in_a), .b(in_b), .sel(in_sel), .y(out_y));


    // Inicialização
    initial begin
        $display ("Testbench para MUX de 2 entradas");
        $dumpfile ("signals.vcd");
        $dumpvars(0,tb_mux);
        # 0 in_a = 0; in_b = 1; in_sel = 0;
        # 10 in_a = 0; in_b = 1; in_sel = 1;
        # 10 in_a = 1; in_b = 0; in_sel = 0;
        # 10 in_a = 1; in_b = 0; in_sel = 1;

        # 10 $finish;   
    end

endmodule