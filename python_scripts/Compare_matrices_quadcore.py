import numpy as np
np.random.seed(64)
import time

def matrix_out_py():
    matrix1 = np.random.randint(256, size=(X,Y))
    matrix2 = np.random.randint(256, size=(Y,Z))
    out_matrix = np.dot(matrix1, matrix2)
    return (out_matrix)

def matrix_out_mem():
    fm31 = open("DRAMInitM31.mem", "r")
    contentsm31 = fm31.readlines()
    contentsm31 = list(map(str.strip,contentsm31))

    fm32 = open("DRAMInitM32.mem", "r")
    contentsm32 = fm32.readlines()
    contentsm32 = list(map(str.strip,contentsm32))

    fm33 = open("DRAMInitM33.mem", "r")
    contentsm33 = fm33.readlines()
    contentsm33 = list(map(str.strip,contentsm33))

    fm34 = open("DRAMInitM34.mem", "r")
    contentsm34 = fm34.readlines()
    contentsm34 = list(map(str.strip,contentsm34))

    mul_matrix = []
    for i in range(3,(XD[0]*Z*3)+3,3):
        value = contentsm31[i+2][-8:] + contentsm31[i+1][-8:] + contentsm31[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(3,(XD[1]*Z*3)+3,3):
        value = contentsm32[i+2][-8:] + contentsm32[i+1][-8:] + contentsm32[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(3,(XD[2]*Z*3)+3,3):
        value = contentsm33[i+2][-8:] + contentsm33[i+1][-8:] + contentsm33[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)

    for i in range(3,(XD[3]*Z*3)+3,3):
        value = contentsm34[i+2][-8:] + contentsm34[i+1][-8:] + contentsm34[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)
    mul_matrix = np.reshape(mul_matrix, (X,Z))
    return (mul_matrix)
    
X = 10
Y = 7
Z = 12

XD = [int(X/4),int(X/4),int(X/4),int(X/4)]
for i in range(int(X%4)):
    XD[i] += 1 
    
start = time.process_time()
for i in range(1000):
    pymatrix = matrix_out_py()
print( "Time taken to multiply using Numpy library is: ")
print(time.process_time() - start)
memmatrix = matrix_out_mem()

print(pymatrix)
print(memmatrix)

print(pymatrix == memmatrix)
