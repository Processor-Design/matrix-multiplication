import numpy as np

m1 = np.random.randint(256, size = (64,64))
m2 = np.random.randint(256, size = (64,64))

m3 = np.dot(m1,m2)
print (m3)