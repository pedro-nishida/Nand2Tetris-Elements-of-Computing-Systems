class VMTranslator:
    def __init__(self, input_file):
        self.input_file = input_file
        self.output_file = input_file.replace('.vm', '.asm')
        self.commands = self.read_commands()
        self.current_command = ''
        self.output = []

    def read_commands(self):
        with open(self.input_file, 'r') as file:
            return [line.strip() for line in file if line.strip() and not line.startswith('//')]

    def parse_command(self):
        parts = self.current_command.split()
        command_type = parts[0]
        if command_type in ['push', 'pop']:
            segment = parts[1]
            index = int(parts[2])
            return command_type, segment, index
        return command_type, None, None

    def translate(self):
        for command in self.commands:
            self.current_command = command
            print(f'Translating command: {command}')  # Debug print
            command_type, segment, index = self.parse_command()
            
            if command_type == 'push':
                self.handle_push(segment, index)
            elif command_type == 'pop':
                self.handle_pop(segment, index)
            else:
                self.handle_arithmetic(command_type)
        self.write_output()

    def handle_push(self, segment, index):
        if segment == 'constant':
            self.output.append(f'@{index}')
            self.output.append('D=A')
        elif segment == 'local':
            self.output.append('@LCL')
            self.output.append('D=M')
            self.output.append(f'@{index}')
            self.output.append('A=D+A')
            self.output.append('D=M')
        elif segment == 'argument':
            self.output.append('@ARG')
            self.output.append('D=M')
            self.output.append(f'@{index}')
            self.output.append('A=D+A')
            self.output.append('D=M')
        elif segment == 'this':
            self.output.append('@THIS')
            self.output.append('D=M')
            self.output.append(f'@{index}')
            self.output.append('A=D+A')
            self.output.append('D=M')
        elif segment == 'that':
            self.output.append('@THAT')
            self.output.append('D=M')
            self.output.append(f'@{index}')
            self.output.append('A=D+A')
            self.output.append('D=M')
        elif segment == 'temp':
            self.output.append(f'@{5 + index}')
            self.output.append('D=M')
        elif segment == 'pointer':
            if index == 0:
                self.output.append('@THIS')
            elif index == 1:
                self.output.append('@THAT')
            self.output.append('D=M')
        elif segment == 'static':
            self.output.append(f'@{self.input_file}.{index}')
            self.output.append('D=M')
        self.output.append('@SP')
        self.output.append('A=M')
        self.output.append('M=D')
        self.output.append('@SP')
        self.output.append('M=M+1')

    def handle_pop(self, segment, index):
        if segment in ['local', 'argument', 'this', 'that']:
            if segment == 'local':
                base = 'LCL'
            elif segment == 'argument':
                base = 'ARG'
            elif segment == 'this':
                base = 'THIS'
            elif segment == 'that':
                base = 'THAT'
            self.output.append(f'@{base}')
            self.output.append('D=M')
            self.output.append(f'@{index}')
            self.output.append('D=D+A')
            self.output.append('@R13')
            self.output.append('M=D')
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('@R13')
            self.output.append('A=M')
            self.output.append('M=D')
        elif segment == 'temp':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append(f'@{5 + index}')
            self.output.append('M=D')
        elif segment == 'pointer':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            if index == 0:
                self.output.append('@THIS')
            elif index == 1:
                self.output.append('@THAT')
            self.output.append('M=D')
        elif segment == 'static':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append(f'@{self.input_file}.{index}')
            self.output.append('M=D')

    def handle_arithmetic(self, command):
        if command == 'add':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('M=M+D')
        elif command == 'sub':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('M=M-D')
        elif command == 'neg':
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=-M')
        elif command == 'eq':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('D=M-D')
            self.output.append('@EQ_TRUE')
            self.output.append('D;JEQ')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=0')
            self.output.append('@EQ_END')
            self.output.append('0;JMP')
            self.output.append('(EQ_TRUE)')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=-1')
            self.output.append('(EQ_END)')
        elif command == 'gt':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('D=M-D')
            self.output.append('@GT_TRUE')
            self.output.append('D;JGT')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=0')
            self.output.append('@GT_END')
            self.output.append('0;JMP')
            self.output.append('(GT_TRUE)')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=-1')
            self.output.append('(GT_END)')
        elif command == 'lt':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('D=M-D')
            self.output.append('@LT_TRUE')
            self.output.append('D;JLT')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=0')
            self.output.append('@LT_END')
            self.output.append('0;JMP')
            self.output.append('(LT_TRUE)')
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=-1')
            self.output.append('(LT_END)')
        elif command == 'and':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('M=M&D')
        elif command == 'or':
            self.output.append('@SP')
            self.output.append('AM=M-1')
            self.output.append('D=M')
            self.output.append('A=A-1')
            self.output.append('M=M|D')
        elif command == 'not':
            self.output.append('@SP')
            self.output.append('A=M-1')
            self.output.append('M=!M')

    def write_output(self):
        with open(self.output_file, 'w') as file:
            file.write('\n'.join(self.output))

if __name__ == '__main__':
    import sys
    import os
    
    if len(sys.argv) != 2:
        print("Usage: python VMTranslator.py <input_file.vm>")
        sys.exit(1)

    input_file = sys.argv[1]
    if not input_file.endswith('.vm'):
        print("Error: Input file must have .vm extension")
        sys.exit(1)

    translator = VMTranslator(input_file)
    translator.translate()
