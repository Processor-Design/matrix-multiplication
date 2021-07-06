import numpy as np
np.random.seed(64)

def matrix_out_py(X=10, Y=7, Z=12):
    matrix1 = np.random.randint(255, size=(X,Y))
    matrix2 = np.random.randint(255, size=(Y,Z))
    out_matrix = np.dot(matrix1, matrix2)
    return (out_matrix)

def matrix_out_mem(X, Z):
    fm31 = open("DRAMInitM31.mem", "r")
    contentsm31 = f.readlines()
    contentsm31 = list(map(str.strip,contentsm31))

    fm32 = open("DRAMInitM32.mem", "r")
    contentsm32 = f.readlines()
    contentsm32 = list(map(str.strip,contentsm32))

    fm33 = open("DRAMInitM33.mem", "r")
    contentsm33 = f.readlines()
    contentsm33 = list(map(str.strip,contentsm33))

    fm34 = open("DRAMInitM34.mem", "r")
    contentsm34 = f.readlines()
    contentsm34 = list(map(str.strip,contentsm34))

    mul_matrix = []
    for i in range(X*Z*3/4,3):
        #print(contents[i][-8:])
        value = contentsm31[i+2][-8:] + contentsm31[i+1][-8:] + contentsm31[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(X*Z*3/4,3):
        #print(contents[i][-8:])
        value = contentsm32[i+2][-8:] + contentsm32[i+1][-8:] + contentsm32[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(X*Z*3/4,3):
        #print(contents[i][-8:])
        value = contentsm33[i+2][-8:] + contentsm33[i+1][-8:] + contentsm33[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(X*Z*3/4,3):
        #print(contents[i][-8:])
        value = contentsm34[i+2][-8:] + contentsm34[i+1][-8:] + contentsm34[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)
        
    mul_matrix = np.reshape(mul_matrix, (X,Z))
    return (mul_matrix)

pymatrix = matrix_out_py()
memmatrix = matrix_out_mem()

print(pymatrix)
print(memmatrix)

print(pymatrix == memmatrix)


