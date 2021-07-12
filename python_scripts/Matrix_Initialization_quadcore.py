def InitMem1(f,Xd,Inc):
    f.write(f'WIDTH={Databits};\n')
    f.write(f'DEPTH={1038};\n')
    f.write(f'ADDRESS_RADIX=UNS;\n')
    f.write(f'DATA_RADIX=UNS;\n')
    f.write(f'CONTENT BEGIN\n')

    Dmat['X'] = Xd
    
    j = 0
    for k in Dmat:
        f.write(f'\t{j} : {Dmat[k]};\n')
        j+=1

    for i in range(M1start,M1start+Xd*Y):
        f.write(f'\t{i} : {VectorM1[i-M1start+Inc]};\n')

    f.write(f'END;\n')

def InitMem2(f):
    f.write(f'WIDTH={Databits};\n')
    f.write(f'DEPTH={4096};\n')
    f.write(f'ADDRESS_RADIX=UNS;\n')
    f.write(f'DATA_RADIX=UNS;\n')
    f.write(f'CONTENT BEGIN\n')

    for i in range(Y*Z):
        f.write(f'\t{i} : {VectorM2[i]};\n')

    f.write(f'END;\n')

def InitMem3(f):
    f.write(f'WIDTH={Databits};\n')
    f.write(f'DEPTH={1024*3};\n')
    f.write(f'ADDRESS_RADIX=UNS;\n')
    f.write(f'DATA_RADIX=UNS;\n')
    f.write(f'CONTENT BEGIN\n')

    f.write(f'END;\n')

import numpy as np
np.random.seed(64)

Databits = 8 #Bit size of data
Maxd = 2**(Databits) #Maximum value of data

#Datas related to matrices
Dmat = {'X':33, 'Y':32, 'Z':31, 'M1start1':None, 'M1start2':None, 'M2start1':None, 'M2start2':None, 'M3start1':None, 'M3start2':None, 'n1':3, 'n2':11, 'blank':0, 'M3end1':0, 'M3end2':0}

X = Dmat['X'] 
Y = Dmat['Y'] 
Z = Dmat['Z'] 

#Divide 16bits into 2 parts of 8bits and convert them to integer
M1start = 14
Dmat['M1start1'] = int('{0:016b}'.format(M1start)[0:8],2)
Dmat['M1start2'] = int('{0:016b}'.format(M1start)[8:16],2)

M2start = '0001000000000000'
Dmat['M2start1'] = int(M2start[0:8],2)
Dmat['M2start2'] = int(M2start[8:16],2)

M3start = '0010000000000000'
Dmat['M3start1'] = int(M3start[0:8],2)
Dmat['M3start2'] = int(M3start[8:16],2)


#Generate matrices with random numbers
Matrix1 = np.random.randint(Maxd, size=(X,Y))
Matrix2 = np.random.randint(Maxd, size=(Y,Z))

#Convert array into 1-D vector
VectorM1 = np.concatenate(Matrix1)
VectorM2 = np.concatenate(Matrix2)

#Create a .mif files for memory instances and write vectors in a specified format
f_m11 = open('MemInitFiles/DRAMInit_M11.mif', 'w')
f_m12 = open('MemInitFiles/DRAMInit_M12.mif', 'w')
f_m13 = open('MemInitFiles/DRAMInit_M13.mif', 'w')
f_m14 = open('MemInitFiles/DRAMInit_M14.mif', 'w')

f_m2 = open('MemInitFiles/DRAMInit_M2.mif', 'w')

f_m31 = open('MemInitFiles/DRAMInit_M31.mif', 'w')
f_m32 = open('MemInitFiles/DRAMInit_M32.mif', 'w')
f_m33 = open('MemInitFiles/DRAMInit_M33.mif', 'w')
f_m34 = open('MemInitFiles/DRAMInit_M34.mif', 'w')


XD = [int(X/4),int(X/4),int(X/4),int(X/4)]
for i in range(int(X%4)):
    XD[i] += 1

#save contents into memory instances
InitMem1(f_m11,XD[0],0)
InitMem1(f_m12,XD[1],XD[0]*Y)
InitMem1(f_m13,XD[2],(XD[0]+XD[1])*Y)
InitMem1(f_m14,XD[3],(XD[0]+XD[1]+XD[2])*Y)

InitMem2(f_m2)

InitMem3(f_m31)
InitMem3(f_m32)
InitMem3(f_m33)
InitMem3(f_m34)