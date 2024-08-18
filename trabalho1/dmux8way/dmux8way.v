//
// DMUX 8-way
//
module dmux8way(
    input wire [7:0] entrada,
    input wire [2:0] sel,
    output reg o0, o1, o2, o3, o4, o5, o6, o7
);
    always @(*) begin
        o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 0; o5 = 0; o6 = 0; o7 = 0;
        case(sel)
            3'b000: o0 = entrada;
            3'b001: o1 = entrada;
            3'b010: o2 = entrada;
            3'b011: o3 = entrada;
            3'b100: o4 = entrada;
            3'b101: o5 = entrada;
            3'b110: o6 = entrada;
            3'b111: o7 = entrada;
        endcase
    end
endmodule