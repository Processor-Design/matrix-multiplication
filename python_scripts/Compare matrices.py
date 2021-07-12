import numpy as np
np.random.seed(64)

X=17
Y=16
Z=15

def matrix_out_py(X=17, Y=16, Z=15):
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

def matrix_out_mem(X=17, Z=15):
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

pymatrix = matrix_out_py(X,Y,Z)
memmatrix = matrix_out_mem(X,Z)

print(pymatrix)
print(memmatrix)

compareMatrix = pymatrix == memmatrix
print(compareMatrix)
print (np.count_nonzero(compareMatrix))
if (np.count_nonzero(compareMatrix) == X*Z):
    print ("Matrix Multiplication Calculaetd Successfully")

