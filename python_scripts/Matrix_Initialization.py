import numpy as np

Databits = 8 #Bit size of data
Maxd = 2**(Databits) #Maximum value of data

#Datas related to matrices
Dmat = {'X':64, 'Y':64, 'Z':64, 'M1start1':None, 'M1start2':None, 'M2start1':None, 'M2start2':None, 'M3start1':None, 'M3start2':None, 'n1':3, 'n2':11, 'blank':0, 'M3end1':None, 'M3end2':None}

X = Dmat['X'] #Raw dimension of matrix1
Y = Dmat['Y'] #Column dimension of matrix1 / Raw dimension of matrix2
Z = Dmat['Z'] #Column dimension of matrix2

#Divide 16bits into 2 parts of 8bits and convert them to integer
M1start = 14
Dmat['M1start1'] = int('{0:016b}'.format(M1start)[0:8],2)
Dmat['M1start2'] = int('{0:016b}'.format(M1start)[8:16],2)

M2start = M1start + X*Y
Dmat['M2start1'] = int('{0:016b}'.format(M2start)[0:8],2)
Dmat['M2start2'] = int('{0:016b}'.format(M2start)[8:16],2)

M3start = M2start + Y*Z
Dmat['M3start1'] = int('{0:016b}'.format(M3start)[0:8],2)
Dmat['M3start2'] = int('{0:016b}'.format(M3start)[8:16],2)

M3end = M3start + X*Z*3 -1
Dmat['M3end1'] = int('{0:016b}'.format(M3end)[0:8],2)
Dmat['M3end2'] = int('{0:016b}'.format(M3end)[8:16],2)

#Generate matrices with random numbers
Matrix1 = np.random.randint(Maxd, size=(X,Y))
Matrix2 = np.random.randint(Maxd, size=(Y,Z))

#Convert array into 1-D vector
VectorM1 = np.concatenate(Matrix1)
VectorM2 = np.concatenate(Matrix2)

#Create a .mif file and write vectors in a specified format
f = open('E:/Processor Design/Codes/DRAM/DRAM_DataInt.mif', 'w')

f.write(f'WIDTH={Databits};\n')
f.write(f'DEPTH={14+X*Y+Y*Z+X*Z*3};\n')
f.write(f'ADDRESS_RADIX=UNS;\n')
f.write(f'DATA_RADIX=UNS;\n')
f.write(f'CONTENT BEGIN\n')

j = 0
for k in Dmat:
    f.write(f'\t{j} : {Dmat[k]};\n')
    j+=1

for i in range(j,j+X*Y):
    f.write(f'\t{i} : {VectorM1[i-j]};\n')
for i in range(j+X*Y,j+X*Y+Y*Z):
    f.write(f'\t{i} : {VectorM2[i-(j+X*Y)]};\n')

f.write(f'END;\n')