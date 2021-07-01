ftxt = open("E:/Processor Design/Codes/matrix-multiplication/python_scripts/encoding.txt","r")
Instructions = ftxt.readlines()
ftxt.close()

fmif = open('E:/Processor Design/Codes/DRAM/IROM_InsInt.mif', 'w')

fmif.write(f'WIDTH={16};\n')
fmif.write(f'DEPTH={150};\n')
fmif.write(f'ADDRESS_RADIX=UNS;\n')
fmif.write(f'DATA_RADIX=BIN;\n')
fmif.write(f'CONTENT BEGIN\n')

j=0
for line in Instructions:
    fmif.write(f'\t{j} : {line.strip()};\n')
    j+=1

fmif.write(f'END;\n')