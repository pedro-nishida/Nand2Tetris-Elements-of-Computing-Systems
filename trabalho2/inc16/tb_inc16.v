`include "inc16.v"

module tb_inc16;
    reg [15:0] a;
    wire [15:0] y;

    inc16 uut (
        .a(a),
        .y(y)
    );

    initial begin
        $display("Testbench para inc16 de 16 bits");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_inc16);

        // Test cases
        a = 16'h0000; #10;
        a = 16'h0001; #10;
        a = 16'h00FF; #10;
        a = 16'h0FFF; #10;
        a = 16'hFFFF; #10;

        $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("t=%03d: \tentrada=%b,saida=%b \n",$time,a,y);
    end

endmodule