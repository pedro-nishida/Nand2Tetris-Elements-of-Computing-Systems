`include "gnot16.v"

module tb_gnot16;

    //inputs
    reg [0:15] in_a;

    //outputs
    wire [0:15] out_y;

    //instanciando da UTT (Unit Under Test)
    gnot16 uut(.a(in_a), .y(out_y));

    //gerando os estímulos
    initial begin
        // "macros do verilog"
        $display("Testbench para o gate XOR combinacional de 16 bits");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_gnot16);
    
        //gerando os estímulos
        # 0 in_a = 16'b0000000000000000;
        # 10 in_a = 16'b0000000000000001;
        # 10 in_a = 16'b0000000000000010;
        # 10 in_a = 16'b0000000000000100;
        # 10 in_a = 16'b0000000000001000;
        # 10 in_a = 16'b0000000000010000;
        # 10 in_a = 16'b0000000000100000;
        # 10 in_a = 16'b0000000001000000;
        # 10 in_a = 16'b0000000010000000;
        # 10 in_a = 16'b0000000100000000;
        # 10 in_a = 16'b0000001000000000;
        # 10 in_a = 16'b0000010000000000;
        # 10 in_a = 16'b0000100000000000;
        # 10 in_a = 16'b0001000000000000;
        # 10 in_a = 16'b0010000000000000;
        # 10 in_a = 16'b0100000000000000;
        # 10 in_a = 16'b1000000000000000;

        # 10 $finish;
    end

    //monitorando os sinais
    initial begin
        $monitor("t=%0t in_a=%b out_y=%b", $time, in_a, out_y);
    end
endmodule