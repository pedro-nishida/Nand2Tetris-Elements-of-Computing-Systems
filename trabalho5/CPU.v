`include "alu.v"
module CPU(
    input wire clk,
    input wire [15:0] inM,          // Entrada do valor M (M = conteúdo da RAM[A])
    input wire [15:0] instruction,  // Instrução para execução
    input wire reset,               // Indica se deve reiniciar o programa atual
                                    // (reset==1) ou continuar executando o
                                    // programa atual (reset==0).

    output wire [15:0] outM,        // Saída do valor M
    output wire loadM,              // Escrever em M?
    output wire [15:0] addressM,    // Endereço na memória de dados (de M) para leitura
    output reg [15:0] pc            // Endereço da próxima instrução
);

    assign addressM = regA;
    wire loadI;
    wire loadA;
    wire loadD;
    assign outM = outALU;    
    wire [15:0] am;
    assign am = (instruction[12]) ? inM : regA;
    wire lt;
    wire eq;
    wire jmp;
    wire inc;
    wire [15:0] outALU;
        
    reg [15:0] regA;
    reg [15:0] regD;


    // Sinais de controle para carregamento de registradores
    assign loadI = ~instruction[15]; // Carrega instrução no registrador A se o bit 15 for 0
    assign loadA = instruction[15] & instruction[5]; // Carrega valor no registrador A se o bit 15 e o bit 5 forem 1
    assign loadD = instruction[15] & instruction[4]; // Carrega valor no registrador D se o bit 15 e o bit 4 forem 1
    assign loadM = instruction[15] & instruction[3]; // Carrega valor na memória se o bit 15 e o bit 3 forem 1

    // Lógica de salto condicional
    assign jmp = instruction[15] & ((lt & instruction[2]) | (eq & instruction[1]) | ((!(lt | eq)) & instruction[0]));

    // Lógica de atualização do contador de programa (PC)
    always @(posedge clk) begin
        if (reset) 
            pc <= 0; // Reseta o PC para 0
        else if (jmp) 
            pc <= regA; // Salta para o endereço no registrador A
        else 
            pc <= pc + 1; // Incrementa o PC
    end

    // Lógica de atualização do registrador A
    always @(posedge clk) begin
        if (reset) 
            regA <= 0; // Reseta o registrador A para 0
        else if (loadI) 
            regA <= instruction; // Carrega a instrução no registrador A
        else if (loadA) 
            regA <= outALU; // Carrega o valor da ALU no registrador A
        else 
            regA <= regA; // Mantém o valor atual do registrador A
    end

    // Lógica de atualização do registrador D
    always @(posedge clk) begin
        if (reset) 
            regD <= 0; // Reseta o registrador D para 0
        else if (loadD) 
            regD <= outALU; // Carrega o valor da ALU no registrador D
        else 
            regD <= regD; // Mantém o valor atual do registrador D
    end

endmodule