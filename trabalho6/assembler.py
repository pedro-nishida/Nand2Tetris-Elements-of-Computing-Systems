import sys
import os

# Tabela de símbolos predefinidos
symbol_table = {
    "SP": 0, "LCL": 1, "ARG": 2, "THIS": 3, "THAT": 4,
    "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5, "R6": 6, "R7": 7,
    "R8": 8, "R9": 9, "R10": 10, "R11": 11, "R12": 12, "R13": 13, "R14": 14, "R15": 15,
    "SCREEN": 16384, "KBD": 24576
}

# Mapas de tradução para instruções C
comp_table = {
    "0": "0101010", "1": "0111111", "-1": "0111010", "D": "0001100", "A": "0110000",
    "!D": "0001101", "!A": "0110001", "-D": "0001111", "-A": "0110011", "D+1": "0011111",
    "A+1": "0110111", "D-1": "0001110", "A-1": "0110010", "D+A": "0000010", "D-A": "0010011",
    "A-D": "0000111", "D&A": "0000000", "D|A": "0010101", "M": "1110000", "!M": "1110001",
    "-M": "1110011", "M+1": "1110111", "M-1": "1110010", "D+M": "1000010", "D-M": "1010011",
    "M-D": "1000111", "D&M": "1000000", "D|M": "1010101"
}

dest_table = {
    "": "000", "M": "001", "D": "010", "MD": "011", "A": "100", "AM": "101", "AD": "110", "AMD": "111"
}

jump_table = {
    "": "000", "JGT": "001", "JEQ": "010", "JGE": "011", "JLT": "100", "JNE": "101", "JLE": "110", "JMP": "111"
}

def main():
    dados = ''
    while True:
        try:
            line = input().strip()
            if line[:2] != "//" and line != '':
                if line[0] == '@':
                    dados += f"{int(line[1:]):016b}\n"
                else:   # Symbolic syntax:  dest = comp ; jump
                        # Binary syntax:    1 1 1 a c c c c c c d d d j j j

                    if '=' in line:
                        line = line.split('=')  # divide a string separando line[0] = dest; line[1] = (comp;jump)
                        dest = dest_table.get(line[0], "000")
                        line = line[1]          # line = (comp;jump)
                    else:
                        dest = "000"

                    if ';' in line: 
                        line = line.split(';')  # divide a string separando line[0] = comp; line[1] = jump
                        jump = jump_table.get(line[1], "000")
                        line = line[0]          # line = comp
                    else:
                        jump = "000"

                    comp = comp_table.get(line, "0000000")
                    dados += f"111{comp}{dest}{jump}\n"

        except EOFError:
            break

    # Nome do arquivo
    nome_arquivo = 'python_out.hack'

    # Abrir o arquivo em modo binário para escrita
    with open(nome_arquivo, 'w') as arquivo:
        arquivo.write(dados[:-1])


if __name__ == "__main__":
    main()