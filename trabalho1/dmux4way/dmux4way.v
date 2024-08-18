//
// DMUX 4-way
//

module dmux4way(
    input wire [3:0]entrada,
    input wire [1:0]sel,
    output reg o0, o1, o2, o3
);

    always @(*) begin
        o0 = 0;
        o1 = 0;
        o2 = 0;
        o3 = 0;

        case(sel)
            2'b00 : o0 = entrada;
            2'b01 : o1 = entrada;
            2'b10 : o2 = entrada;
            2'b11 : o3 = entrada;
        endcase
    end

endmodule