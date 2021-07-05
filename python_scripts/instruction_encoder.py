import re
instructionsFile = open('instructions.txt', 'r')
instructions = instructionsFile.readlines()
instructions = list(map(str.strip,instructions))
instructions = list(filter(None, instructions))

IA = {
    "NOP": 4,
    "ADD": 5,
    "MUL": 7,
    "SUB": 9,
    "LODAC": 11,
    "LODACAR": 16,
    "STOAC": 18,
    "MVAC": 20,
    "MOVREG": 21,
    "CLAC": 22,
    "JUMP": 24,
    "JUMPZ": 27,
    "JMNZ": 29,
    "INCAC": 31,
    "INCR": 32,
    "INCR3": 33,
    "SFTR": 34,
    "SFTL": 36,
    "MOVAR": 38,
    "ENDOP": 40,
}

typeA = ["ADD", "MVAC", "MOVREG", "MOVAR"]

regOrder = ["X", "Y", "Z", "STXY", "STYZ", "STXZ", "R", "R1", "R2", "R3", "DR"]

addReg = ["R", "R1", "R2"]

LOOPS = {}

for i in range(len(instructions)):
    temp = ""
    ins = list(filter(None, re.split('\s|,|\'|\\\\', instructions[i])))
    print ((i+1), ": ",ins)
    if len(ins) > 2: #Assuming LOOP {NUMBER} comment will have a prior Instruction
        if "LOOP" in ins:
            LOOPS[ins[-1]] = i #Assuming comment ends in Loop Number
print ("LOOPS: ", LOOPS)

encoding = ""

for insLine in instructions:
    temp = ""
    ins = list(filter(None, re.split('\s|,|\'|\\\\', insLine)))
    print (ins)
    if (ins[0] in list(IA.keys())):
        temp = "{:08b}".format(IA[ins[0]])
        if ins[0] in typeA:
            if ins[0] == "ADD":
                temp += "{:08b}".format(addReg.index(ins[1])+ 1)
                temp += "\n"
            else:
                temp += "{:08b}".format(regOrder.index(ins[1])+ 1)
                temp += "\n"
        else:
            temp += "{:08b}".format(0)
            temp += "\n"
    elif ins[0] == "16":
        temp += "{:016b}".format(int(ins[1]))
        temp += "\n"
    elif ins[0] == "LOOP":
        temp += "{:08b}".format(0)
        temp += "{:08b}".format(LOOPS[ins[1]])
        temp += "\n"
    elif (len(ins)) > 0: #Assuming instruction is a comment
        temp = "{:08b}".format(IA["NOP"])
        temp += "{:08b}".format(0)
        temp += "\n"
    if len(temp) == 0:
        temp = "Encoding Error: "+ insLine +"\n"
    encoding += temp

encodingFile = open("encoding.txt", "w")
encodingFile.write(encoding)
encodingFile.close()