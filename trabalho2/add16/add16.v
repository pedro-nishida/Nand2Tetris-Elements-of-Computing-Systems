//
//add16: adição de dois número de 16 bits
// using fulladder
//
`include "fulladder.v"

module add16 (
    input [15:0] a, // 16 bits de entrada
    input [15:0] b, // 16 bits de entrada
    input cin, // bit de carry de entrada
    output [15:0] sum, // 16 bits de saída
    output cout // bit de carry de saída
    );

    wire [15:0] carry;

    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : full_adder_block
            if (i == 0) begin
                fulladder fa (.a(a[i]), .b(b[i]), .c(carry[i]), .sum(sum[i]), .carry(carry[i+1]));
            end else if (i == 15) begin
                fulladder fa (.a(a[i]), .b(b[i]), .c(carry[i]), .sum(sum[i]), .carry(cout));
            end else begin
                fulladder fa (.a(a[i]), .b(b[i]), .c(carry[i]), .sum(sum[i]), .carry(carry[i+1]));
            end
        end
    endgenerate

endmodule