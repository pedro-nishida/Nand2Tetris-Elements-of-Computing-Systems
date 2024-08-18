//
// Multiplexador de quatro entradas (16 bit), comportamental
//

module mux4way16(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] c,
    input wire [15:0] d,
    input wire [1:0] sel,
    output wire [15:0] y
);
    
    assign y = (sel == 2'b00) ? a : 
               (sel == 2'b01) ? b : 
               (sel == 2'b10) ? c : 
               (sel == 2'b11) ? d : 16'b0;
endmodule