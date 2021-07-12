import numpy as np
np.random.seed(64)
import time

def matrix_out_py(X, Y, Z):
    matrix1 = np.random.randint(256, size=(X,Y))
    matrix2 = np.random.randint(256, size=(Y,Z))
    out_matrix = np.dot(matrix1, matrix2)
    return (out_matrix)

def compare_matrices(matrix1, matrix2):
    f_compare = (matrix1 == matrix2)
    m1 = np.matrix(matrix1)
    m2 = np.matrix(matrix2)
    e_compare = (m1==m2)
    return (f_compare,e_compare)

def matrix_out_mem(X, Z):
    f = open("DRAM data.mem", "r")
    contents = f.readlines()
    contents = list(map(str.strip,contents))

    mul_matrix = []
    for i in range(8209,8209+X*Z*3,3):
        #print(contents[i][-8:])
        value = contents[i+2][-8:] + contents[i+1][-8:] + contents[i][-8:]
        value = int(value,2)
        mul_matrix.append(value)
        
    mul_matrix = np.reshape(mul_matrix, (X,Z))
    return (mul_matrix)

X =10
Y = 7
Z = 12

start = time.process_time()
for i in range(1000):
    pymatrix = matrix_out_py()
print( "Time taken to multiply using Numpy library is: ")
print(time.process_time() - start)

memmatrix = matrix_out_mem(X,Z)

print(pymatrix)
print(memmatrix)

print(pymatrix == memmatrix)


