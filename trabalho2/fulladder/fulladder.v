//
// Gate de Full-adder; somador de 1 bit
//
module fulladder (
    input a, // bit de entrada
    input b, // bit de entrada
    input c, // bit de carry
    output sum, // bit de saída
    output carry // bit de carry
    );
    
    wire w1,w2,w3;
    
    assign w1 = a ^ b; // XOR
    assign sum = w1 ^ c; // XOR
    assign w2 = a & b; // AND
    assign w3 = w1 & c; // AND
    assign carry = w2 | w3; // OR

endmodule