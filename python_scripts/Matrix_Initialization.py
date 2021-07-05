import numpy as np
np.random.seed(64)

Databits = 8 #Bit size of data
Maxd = 2**(Databits) #Maximum value of data

#Datas related to matrices
Dmat = {'X':2, 'Y':2, 'Z':2, 'M1start1':None, 'M1start2':None, 'M2start1':None, 'M2start2':None, 'M3start1':None, 'M3start2':None, 'n1':3, 'n2':11, 'blank':0, 'M3end1':None, 'M3end2':None}

X = Dmat['X'] #Raw dimension of matrix1
Y = Dmat['Y'] #Column dimension of matrix1 / Raw dimension of matrix2
Z = Dmat['Z'] #Column dimension of matrix2

#Divide 16bits into 2 parts of 8bits and convert them to integer
M1start = 14
Dmat['M1start1'] = int('{0:016b}'.format(M1start)[0:8],2)
Dmat['M1start2'] = int('{0:016b}'.format(M1start)[8:16],2)

M2start = M1start + 4096
Dmat['M2start1'] = int('{0:016b}'.format(M2start)[0:8],2)
Dmat['M2start2'] = int('{0:016b}'.format(M2start)[8:16],2)

M3start = M2start + 4096
Dmat['M3start1'] = int('{0:016b}'.format(M3start)[0:8],2)
Dmat['M3start2'] = int('{0:016b}'.format(M3start)[8:16],2)

M3end = M3start + (4096 * 3) -1
Dmat['M3end1'] = int('{0:016b}'.format(M3end)[0:8],2)
Dmat['M3end2'] = int('{0:016b}'.format(M3end)[8:16],2)

#Generate matrices with random numbers
Matrix1 = np.random.randint(Maxd, size=(X,Y))
Matrix2 = np.random.randint(Maxd, size=(Y,Z))

#Convert array into 1-D vector
VectorM1 = np.concatenate(Matrix1)
VectorM2 = np.concatenate(Matrix2)

#Create a .mif file and write vectors in a specified format
f = open('DRAM_DataInt.mif', 'w')

f.write(f'WIDTH={Databits};\n')
f.write(f'DEPTH={14+4096*5};\n')
f.write(f'ADDRESS_RADIX=UNS;\n')
f.write(f'DATA_RADIX=UNS;\n')
f.write(f'CONTENT BEGIN\n')

j = 0
for k in Dmat:
    f.write(f'\t{j} : {Dmat[k]};\n')
    j+=1

for i in range(M1start,M1start+X*Y):
    f.write(f'\t{i} : {VectorM1[i-M1start]};\n')
for i in range(M2start,M2start+Y*Z):
    f.write(f'\t{i} : {VectorM2[i-M2start]};\n')

f.write(f'END;\n')