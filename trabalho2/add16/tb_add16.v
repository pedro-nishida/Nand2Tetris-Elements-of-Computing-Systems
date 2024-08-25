`include "add16.v"

module tb_add16;

    // inputs
    reg [15:0] in_a;
    reg [15:0] in_b;
    reg in_cin;

    // outputs
    wire [15:0] out_sum;
    wire out_cout;

    // Instantiate the UUT (Unit Under Test)
    add16 uut (
        .a(in_a),
        .b(in_b),
        .cin(in_cin),
        .sum(out_sum),
        .cout(out_cout)
    );

    initial begin
        $display("Testbench para add16 de 16 bits");
        $dumpfile("signals.vcd");
        $dumpvars(0,tb_add16);

    // Test cases
        in_a = 16'b0000001000000010; in_b = 16'b0000000000000011; in_cin = 0; #10;
        in_a = 16'b0000000000000000; in_b = 16'b0000000011111111; in_cin = 0; #10;
        in_a = 16'b0111011100000000; in_b = 16'b1011000010110000; in_cin = 0; #10;
        in_a = 16'b1111111111111111; in_b = 16'b1111111111111111; in_cin = 0; #10;

        #10 $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("t=%03d: \tentrada=%b,%b,%b,o=%b,c=%b \n",$time,in_a,in_b,in_cin,out_sum,out_cout);
    end

endmodule