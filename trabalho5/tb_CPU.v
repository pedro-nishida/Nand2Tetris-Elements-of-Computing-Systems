// módulos usados
`include "CPU.v"

module tb_CPU;
    // Definições dos sinais
    reg clk;                     // Clock
    reg reset;                   // Sinal de reset
    reg [15:0] inM;              // Valor de entrada M (memória)
    reg [15:0] instruction;      // Instrução para execução
    wire [15:0] outM;            // Valor de saída M (memória)
    wire loadM;                  // Sinal para escrever em M
    wire [15:0] addressM;        // Endereço da memória de dados (M)
    wire [15:0] pc;              // Contador de programa (program counter)

    // Instância da CPU
    CPU uut (
        .clk(clk),
        .inM(inM),
        .instruction(instruction),
        .reset(reset),
        .outM(outM),
        .loadM(loadM),
        .addressM(addressM),
        .pc(pc)
    );

    // Gerador de clock
    always
        #1 clk = ~clk;  

    // Como os sinais irão variar durante a simulação
    initial begin
        $display("Testando o módulo CPU");
        $dumpfile("signals.vcd");
        $dumpvars(0, tb_CPU);
        // Inicializando os sinais
        clk = 0;
        reset = 0;
        inM = 16'd0;
        instruction = 16'd0;

        // Resetando a CPU
        reset = 1;
        #2;
        reset = 0;

        // Teste 1: Carregar @12345 no registrador A (A = 12345)
        instruction = 16'b0011000000111001;  // @12345
        #2;  // Espera 2 unidades de tempo (um ciclo de clock completo)
        
        // Teste 2: Executar D=A (D = 12345)
        instruction = 16'b1110110000010000;  // D=A
        #2;

        // Teste 3: Carregar @23456 no registrador A (A = 23456)
        instruction = 16'b0101101110100000;  // @23456
        #2;

        // Teste 4: Executar D=A-D (D = A-D)
        instruction = 16'b1110000111010000;  // D=A-D
        #2;

        // Teste 5: Carregar @1000 no registrador A (A = 1000)
        instruction = 16'b0000001111101000;  // @1000
        #2;

        // Teste 6: Executar M=D (M = D)
        instruction = 16'b1110001100001000;  // M=D
        #2;

        // Teste 7: Carregar @1001 no registrador A (A = 1001)
        instruction = 16'b0000001111101001;  // @1001
        #2;

        // Teste 8: Executar MD=D-1 (M e D = D-1)
        instruction = 16'b1110001110011000;  // MD=D-1
        #2;

        // Teste 9: Carregar @1000 no registrador A (A = 1000)
        instruction = 16'b0000001111101000;  // @1000
        #2;

        // Teste 10: Executar D=D-M (D = D - M)
        instruction = 16'b1111010011010000;  // D=D-M
        inM = 16'b11111;                     // Define inM como 11111 (valor da memória)
        #2;

        // Continue com os outros testes conforme necessário, usando o mesmo padrão de delays e configurações.
        
        // Finalizando a simulação
        $finish;
    end

endmodule
