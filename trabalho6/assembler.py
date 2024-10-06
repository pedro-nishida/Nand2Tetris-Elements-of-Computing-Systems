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
# Função para analisar uma linha, removendo comentários e espaços em branco
def parse_line(line):
    line = line.split("//")[0].strip()  # Remove comentários e espaços em branco
    return line if line else None

#########################################################################
# Primeira passagem: registra os rótulos (labels) na tabela de símbolos
def first_pass(lines):
    line_number = 0
    for line in lines:
        parsed_line = parse_line(line)
        if parsed_line:
            if parsed_line.startswith("(") and parsed_line.endswith(")"):
                symbol = parsed_line[1:-1]
                symbol_table[symbol] = line_number
            else:
                line_number += 1

#########################################################################
# Segunda passagem: traduz as instruções para código binário
def second_pass(lines):
    instructions = []
    variable_address = 16
    for line in lines:
        parsed_line = parse_line(line)
        if parsed_line:
            if parsed_line.startswith("@"):
                # Instrução A
                symbol = parsed_line[1:]
                if symbol.isdigit():
                    # Se for um número, converte diretamente para binário
                    address = int(symbol)
                else:
                    # Se for um símbolo, resolve o endereço
                    if symbol not in symbol_table:
                        symbol_table[symbol] = variable_address
                        variable_address += 1
                    address = symbol_table[symbol]
                # Adiciona a instrução A em binário à lista
                instructions.append(f"{address:016b}")
            elif "=" in parsed_line or ";" in parsed_line:
                # Instrução C
                dest, comp, jump = "", parsed_line, ""
                if "=" in parsed_line:
                    # Separa destino e computação
                    dest, comp = parsed_line.split("=")
                if ";" in comp:
                    # Separa computação e salto
                    comp, jump = comp.split(";")
                # Adiciona a instrução C em binário à lista
                instructions.append("111" + comp_table[comp] + dest_table[dest] + jump_table[jump])
    return instructions

#########################################################################
# Função principal para montar o arquivo de entrada e gerar o arquivo de saída
def assemble(input_file):
    output_file = os.path.splitext(input_file)[0] + ".bin"
    
    with open(input_file, 'r') as file:
        lines = file.readlines()

    first_pass(lines)
    instructions = second_pass(lines)

    with open(output_file, 'w') as file:
        for instruction in instructions:
            file.write(instruction + "\n")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python assembler.py input.asm")
        sys.exit(1)

    input_file = sys.argv[1]
    assemble(input_file)