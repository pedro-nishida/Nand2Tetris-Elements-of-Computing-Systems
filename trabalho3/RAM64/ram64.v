module ram64(input [15:0] in, input [5:0] address, input load, input clk, output reg [15:0] out);
    reg [15:0] ram [63:0]; // Memória RAM com 64 registradores de 16 bits
    integer i; // Declaração da variável fora do bloco initial

    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            ram[i] = 16'h0000; // Inicializa a memória com zeros
        end
    end

    always @ (posedge clk) begin
        if (load) begin
            ram[address] <= in; // Escreve na memória se load estiver ativo
        end
        out <= ram[address]; // Lê da memória no próximo ciclo de clock
    end

endmodule