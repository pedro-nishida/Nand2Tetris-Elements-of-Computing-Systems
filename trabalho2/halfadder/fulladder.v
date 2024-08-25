//
// Gate de Half-adder; meio somador de 1 bit
//
module tb_fulladder (
    input a, // bit de entrada
    input b, // bit de entrada
    output sum, // bit de saída
    output carry // bit de carry
    );
    
    assign sum = a ^ b; // XOR
    assign carry = a & b; // AND
    

// Instancia da UUT (Unit Under Test)
    fulladder uut (.a(a), .b(b), .sum(sum), .carry(carry));

// Como os sinais irao variar durante a simulacao
    initial begin
        $display("Testbench para Demultiplexador de duas entradas");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_fulladder);

        # 0 a = 0; b = 0;
        # 10 a = 0; b = 1;
        # 10 a = 1; b = 0;
        # 10 a = 1; b = 1;

        # 10 $finish;
    end

  // Monitora os sinais
    initial begin
        $monitor("t=%03d: \tentrada=%d,%d,o0=%d,o1=%d \n",$time,a,b,sum,carry);
    end


endmodule