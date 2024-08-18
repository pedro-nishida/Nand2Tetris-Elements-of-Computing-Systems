//
// Test Bench para Gate XOR combinacional
//

// modulos usados
`include "gxor.v"

module tb_gxor;
    reg in_a;
    reg in_b;
    wire out_y;

    gxor uut(.a(in_a), .b(in_b), .y(out_y));

    initial begin
        $display ("Testbench para XXOR combinacional");
        $dumpfile ("signals.vcd");
        $dumpvars(0,tb_gxor);
        # 0 in_a = 0; in_b = 0;
        # 10 in_a = 0; in_b = 1;
        # 10 in_a = 1; in_b = 0;
        # 10 in_a = 1; in_b = 1;

        # 10 $finish;   
    end

    initial begin
    $monitor("t=%03d: \ta=%d,b=%d,y=%d\n",$time,in_a,in_b,out_y);
    end
endmodule