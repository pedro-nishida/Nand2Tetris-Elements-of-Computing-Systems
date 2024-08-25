`include "ram64.v"

module tb_ram64;

    // inputs
    reg [15:0] in_in;
    reg in_load;
    reg [5:0] in_address;
    reg clk;

    // outputs
    wire [15:0] out_out;

    // Instancia da UUT (Unit Under Test)
    ram64 uut (.in(in_in), .address(in_address), .load(in_load), .clk(clk), .out(out_out));

    initial begin
        $display("Testbench para ram64");
        $dumpfile("signals.vcd");
        $dumpvars(0, tb_ram64);

        // Inicializa os sinais
        clk = 0;
        in_in = 0;
        in_load = 0;
        in_address = 0;

        // Pequeno atraso para garantir que o primeiro ciclo de clock seja capturado corretamente
        #2;

        // Gera sinais aleatorios
        for (integer i = 0; i < 64; i = i + 1) begin
            in_in = $random;
            in_address = $random % 64; // Garante que o endereço esteja dentro do intervalo de 6 bits

            #4 in_load = $random % 2; // Gera um valor aleatório de 0 ou 1 para in_load
        end
        
        #5 $finish;
    end

    // Monitora os sinais
    initial begin
        $monitor("t=%03d: \tclk=%d, in_load=%d, in_address=%d, in_in=%d, out_out=%d \n", $time, clk, in_load, in_address, in_in, out_out);
    end

    // Gerador de clock
    always 
        #1 clk = ~clk;

endmodule