//
// Multiplexador de oito entradas (16 bit), comportamental
//

module mux8way16(
    input wire [15:0] a, b, c, d, e, f, g, h,
    input wire [2:0] sel,
    output wire [15:0] y
);
    assign y = (sel == 3'b000) ? a : 
               (sel == 3'b001) ? b : 
               (sel == 3'b010) ? c : 
               (sel == 3'b011) ? d : 
               (sel == 3'b100) ? e : 
               (sel == 3'b101) ? f : 
               (sel == 3'b110) ? g : 
               (sel == 3'b111) ? h : 16'b0;
endmodule