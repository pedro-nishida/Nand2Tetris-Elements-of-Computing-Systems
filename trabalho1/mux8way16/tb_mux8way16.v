`include "mux8way16.v"

module tb_mux8way16;
    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] y;

    mux8way16 uut (.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h), .sel(sel), .y(y));

    initial begin
        $display("Testbench para multiplexador de 8 entradas 16bit");
        $dumpfile("signals.vcd");
        $dumpvars(0, tb_mux8way16);

        a = 16'hAAAA; b = 16'h5555; c = 16'h0F0F; d = 16'hF0F0;
        e = 16'h1234; f = 16'h5678; g = 16'h9ABC; h = 16'hDEF0; sel = 3'b000;
        #10 sel = 3'b001;
        #10 sel = 3'b010;
        #10 sel = 3'b011;
        #10 sel = 3'b100;
        #10 sel = 3'b101;
        #10 sel = 3'b110;
        #10 sel = 3'b111;
        #10 $finish;
    end

    initial $monitor("a=%h b=%h c=%h d=%h e=%h f=%h g=%h h=%h sel=%b -> y=%h", a, b, c, d, e, f, g, h, sel, y);
endmodule