module alu(
    // Entradas
    input [15:0] x, 
    input [15:0] y,     
    input zx, 
    input nx, 
    input zy, 
    input ny, 
    input f, 
    input no,
    // Saídas
    output reg [15:0] out,      
    output zr, 
    output ng    
);

    // Combina os sinais de controle em um único barramento
    wire [5:0] sel;
    assign sel = {zx, nx, zy, ny, f, no};

    // Operação da ALU baseada nos sinais de controle
    always @(*) begin
        case (sel)
            6'b101010: out = 0;         // Zero
            6'b111111: out = 1;         // Um
            6'b111010: out = -1;        // Menos Um
            6'b001100: out = x;         // Passa x
            6'b110000: out = y;         // Passa y
            6'b001101: out = ~x;        // NOT x
            6'b110001: out = ~y;        // NOT y
            6'b001111: out = -x;        // Negativo de x
            6'b110011: out = -y;        // Negativo de y
            6'b011111: out = x + 1;     // Incrementa x
            6'b110111: out = y + 1;     // Incrementa y
            6'b000010: out = x + y;     // Soma x e y
            6'b010011: out = x - y;     // Subtrai y de x
            6'b000111: out = y - x;     // Subtrai x de y
            6'b000000: out = x & y;     // AND x e y
            6'b010101: out = x | y;     // OR x e y
            default: out = 16'hxxxx;    // Operação indefinida
        endcase
    end

    // Sinal de zero: ativado se a saída for zero
    assign zr = (out == 0) ? 1 : 0;

    // Sinal de negativo: ativado se o bit mais significativo da saída for 1
    assign ng = out[15];

endmodule