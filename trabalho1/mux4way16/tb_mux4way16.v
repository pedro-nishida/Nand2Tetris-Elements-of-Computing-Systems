`include "mux4way16.v"

module tb_mux4way16;
    // Declaração dos sinais de entrada e saída
    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] c;
    reg [15:0] d;
    reg [1:0] sel;
    wire [15:0] y;

    // Instanciação do módulo mux4way16
    mux4way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .y(y)
    );

    // Bloco inicial para aplicar os estímulos
    initial begin
        $display("Testbench para multiplexador de 4 entradas 16bit");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_mux4way16);

        // Aplicar diferentes combinações de entradas
        a = 16'hAAAA; b = 16'h5555; c = 16'h0F0F; d = 16'hF0F0; 
        sel = 2'b00;

        #10 sel = 2'b01;
        #10 sel = 2'b10;
        #10 sel = 2'b11;
        #10 sel = 2'b00;

        // Finalizar a simulação
        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b c=%b d=%b sel=%b -> y=%b", a, b, c, d, sel, y);
    end
endmodule
