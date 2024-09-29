module alu(
    //Entradas
    input [15:0] x, 
    input [15:0] y,     
    input zx, 
    input nx, 
    input zy, 
    input ny, 
    input f, 
    input no,
    //Saidas
    output reg [15:0] out,      
    output zr, 
    output ng    
    );

    wire [5:0] sel;
    assign sel[5] = zx;
    assign sel[4] = nx;
    assign sel[3] = zy;
    assign sel[2] = ny;
    assign sel[1] = f;
    assign sel[0] = no;

    always @(*) begin
        case (sel)
            6'b101010: out = 0;
            6'b111111: out = 1;
            6'b111010: out = -1;
            6'b001100: out = x;
            6'b110000: out = y;
            6'b001101: out = ~x;
            6'b110001: out = ~y;
            6'b001111: out = -x;
            6'b110011: out = -y;
            6'b011111: out = x+1;
            6'b110111: out = y+1;
            6'b000010: out = x + y;
            6'b010011: out = x - y;
            6'b000111: out = y - x;
            6'b000000: out = x & y;
            6'b010101: out = x | y;
        endcase
    end

    assign zr = (out == 0) ? 1 : 0;
    assign ng = out[15];

endmodule