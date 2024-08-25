`include "register.v"

module tb_register;

    // inputs
    reg [15:0] in;
    reg load;
    
    // outputs
    wire [15:0] out;

// Instancia da UUT (Unit Under Test)
    register uut (.in(in), .load(load), .out(out));

// Inicializa a simulação e define como os sinais irão variar
    initial begin
        $display("Testbench para register");
        $dumpfile("signals.vcd"); // Cria um arquivo VCD para armazenar os sinais
        $dumpvars(0, tb_register); // Salva todas as variáveis do módulo tb_register

        #0 in = $random; load = 1; // Inicializa os sinais com valores aleatórios

    // Loop para gerar variações nos sinais
        for (integer i = 0; i < 10; i = i + 1) begin
            in = $random; // Gera um valor aleatório para o sinal de entrada

            #4 load = $random; // Alterna aleatoriamente o sinal de load a cada 4 unidades de tempo
        end

        #5 $finish; // Termina a simulação após um pequeno atraso
    end

// Monitora e exibe os sinais durante a simulação   
    initial begin
        $monitor("t=%03d: \tin=%d, load=%d, out=%d \n", $time, in, load, out);
    end

endmodule