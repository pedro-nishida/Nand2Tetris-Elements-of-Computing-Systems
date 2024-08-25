`include "bit.v"

module tb_bit;

    // inputs
    reg in;
    reg load;
    
    // outputs
    wire out;

    // Instancia da UUT (Unit Under Test)
    bit uut (.in(in), .load(load), .out(out));

    initial begin
        $display("Testbench para bit");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_bit);

        #5;
        repeat (30) begin
            #5 in = $random % 2;
            load = $random % 2;
        end

        # 5 $finish;
    end

    initial begin
        $monitor("t=%03d: \tin=%d,load=%d,out=%d \n",$time,in,load,out);
    end

endmodule