`include "alu.v"
module CPU(
    input wire clk,
    input wire [15:0] inM,          // M value input  (M = contents of RAM[A])
    input wire [15:0] instruction,  // Instruction for execution
    input wire reset,               // Signals whether to re-start the current
                                    // program (rstn==1) or continue executing
                                    // the current program (rstn==0).

    output wire [15:0] outM,        // M value output
    output wire loadM,              // Write to M? 
    output wire [15:0] addressM,    // Address in data memory (of M) to read
    output reg [15:0] pc            // address of next instruction
);

    // your implementation comes here:

    assign addressM = regA;
    wire loadI;
    wire loadA;
    wire loadD;
    assign outM = outALU;    
    wire [15:0] am;
    assign am = (instruction[12]) ? inM : regA;
    wire lt;
    wire eq;
    wire jmp;
    wire inc;
    wire [15:0] outALU;
        
    reg [15:0] regA;
    reg [15:0] regD;

    alu alu_0(
        .x(regD),
        .y(am),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
        .out(outALU),
        .zr(eq),
        .ng(lt)
    );
    assign loadI = ~instruction[15];
    assign loadA = instruction[15] & instruction[5];
    assign loadD = instruction[15] & instruction[4];
    assign loadM = instruction[15] & instruction[3];
    assign jmp = instruction[15] & ((lt & instruction[2]) | (eq & instruction[1]) | ((!(lt|eq)) & instruction[0]));
    
    always @(posedge clk)
        if (reset) pc <= 0;
        else if (jmp) pc <= regA;
        else pc <= pc+1;

    always @(posedge clk)
        if (reset) regA <= 0;
        else if (loadI) regA <= instruction;
        else if (loadA) regA <= outALU;
        else regA <= regA;
    
    always @(posedge clk)
        if (reset) regD <= 0;
        else if (loadD) regD <= outALU;
        else regD <= regD;
    
endmodule