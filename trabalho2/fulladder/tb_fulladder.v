`include "fulladder.v"

module tb_fulladder;

// inputs
    reg in_a;
    reg in_b;
    reg in_c;
// outputs
    wire out_sum;
    wire out_carry;

// Instancia da UUT (Unit Under Test)
    fulladder uut (.a(in_a), .b(in_b), .c(in_c), .sum(out_sum), .carry(out_carry));

// Como os sinais irao variar durante a simulacao
    initial begin
    $display("Testbench para Full-adder de 1 bit");
    $dumpfile("signals.vcd");
    $dumpvars(0,tb_fulladder);

    # 0 in_a = 0; in_b = 0; in_c = 0;
    # 10 in_a = 0; in_b = 0; in_c = 1;
    # 10 in_a = 0; in_b = 1; in_c = 0;
    # 10 in_a = 0; in_b = 1; in_c = 1;
    # 10 in_a = 1; in_b = 0; in_c = 0;
    # 10 in_a = 1; in_b = 0; in_c = 1;
    # 10 in_a = 1; in_b = 1; in_c = 0;
    # 10 in_a = 1; in_b = 1; in_c = 1;

    # 10 $finish;
    end

  // Monitora os sinais
    initial begin
        $monitor("t=%03d: \tentrada=%d,%d,%d,o0=%d,o1=%d \n",$time,in_a,in_b,in_c,out_sum,out_carry);
    end

endmodule