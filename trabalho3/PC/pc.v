// program counter
module pc(
    input [15:0] in, 
    input load, 
    input inc, 
    input reset, 
    output reg [15:0] out, 
    input clk
);
    // Inicializa o registrador diretamente na declaração
    reg [15:0] out = 0;

    always @ (posedge clk) begin
        if (reset) begin
            out <= 0;
        end else if (load) begin
            out <= in;
        end else if (inc) begin
            out <= out + 1;
        end
    end
endmodule