`include "alu.v"

module alu_tb;
    // Entradas
    reg [15:0] in_x; // Entrada x
    reg [15:0] in_y; // Entrada y
    reg in_zx; // Zero extend x
    reg in_nx; // Negate x
    reg in_zy; // Zero extend y
    reg in_ny; // Negate y
    reg in_f; // Função
    reg in_no; // Negate out

    // Saídas
    wire [15:0] out; // Saída
    wire zr; // Zero result
    wire ng; // Negative result

    // Instancia o ALU
    alu uut (
        .x(in_x), 
        .y(in_y), 
        .zx(in_zx), 
        .nx(in_nx), 
        .zy(in_zy), 
        .ny(in_ny), 
        .f(in_f), 
        .no(in_no), 
        .out(out), 
        .zr(zr), 
        .ng(ng)
    );

    initial begin
        $display("Testbench para o ALU");
        $dumpfile("signals.vcd");
        $dumpvars(0, alu_tb);

        # 0 in_x = 16'h0000; in_y = 16'h0000; in_zx = 1; in_nx = 0; in_zy = 1; in_ny = 0; in_f = 1; in_no = 0;
        # 10 in_x = 16'hFFFF; in_y = 16'h0000; in_zx = 1; in_nx = 1; in_zy = 1; in_ny = 1; in_f = 1; in_no = 1;
        # 10 in_x = $random; in_y = $random; in_zx = 1; in_nx = 1; in_zy = 1; in_ny = 0; in_f = 1; in_no = 0;
        # 10 in_x = $random; in_y = $random; in_zx = 0; in_nx = 0; in_zy = 1; in_ny = 1; in_f = 0; in_no = 0;
        # 10 in_x = $random; in_y = $random; in_zx = 1; in_nx = 1; in_zy = 0; in_ny = 0; in_f = 0; in_no = 0;
        # 10 in_x = $random; in_y = $random; in_zx = 0; in_nx = 0; in_zy = 1; in_ny = 1; in_f = 0; in_no = 1;
        # 10 in_x = $random; in_y = $random; in_zx = 1; in_nx = 1; in_zy = 0; in_ny = 0; in_f = 0; in_no = 1;
        # 10 in_x = $random; in_y = $random; in_zx = 0; in_nx = 0; in_zy = 1; in_ny = 1; in_f = 1; in_no = 1;
        # 10 in_x = $random; in_y = $random; in_zx = 1; in_nx = 1; in_zy = 0; in_ny = 0; in_f = 1; in_no = 1;
        # 10 in_x = 16'hFFFF; in_y = 16'hFFFF; in_zx = 0; in_nx = 1; in_zy = 1; in_ny = 1; in_f = 1; in_no = 1;

        # 10 $finish;
    end

    initial begin
        $monitor("Tempo: %0d, x: %h, y: %h, zx: %b, nx: %b, zy: %b, ny: %b, f: %b, no: %b, out: %h, zr: %b, ng: %b", 
                 $time, in_x, in_y, in_zx, in_nx, in_zy, in_ny, in_f, in_no, out, zr, ng);
    end
endmodule