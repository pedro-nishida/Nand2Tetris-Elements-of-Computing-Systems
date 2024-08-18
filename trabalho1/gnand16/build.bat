REM compila o design e o testbench, gerando um arquivo de design().vvp)
iverilog -o design.vvp tb_gand16.v 

REM Verifica a saída do design
vvp design.vvp

REM Invoca o GTKWave para visualizar as ondas
gtkwave signals.vcd
