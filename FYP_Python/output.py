import torch
import numpy as np
import struct


model = torch.load('./model/LeNet5.pth').to(torch.float16)

#get c1 weight and bias
c1_weight = model._modules['c1'].weight.cpu().detach().numpy()
c1_bias = model._modules['c1'].bias.cpu().detach().numpy()

c1_weight_hex = np.zeros([6,5,5], dtype='<U4')
c1_bias_hex = np.zeros([6], dtype='<U4')

for i in range(6):
    c1_bias_hex[i] = struct.pack('>e', c1_bias[i]).hex()
    for j in range(5):
        for k in range(5):
            c1_weight_hex[i,j,k] = struct.pack('>e', c1_weight[i,0,j,k]).hex()

c1_weight_hex = c1_weight_hex.reshape((c1_weight_hex.shape[0]*c1_weight_hex.shape[1]),c1_weight_hex.shape[2])
c1_weight = c1_weight.reshape((c1_weight.shape[0]*c1_weight.shape[1]*c1_weight.shape[2]),c1_weight.shape[3])
np.savetxt(f'./weights/c1_bias.txt',c1_bias_hex,fmt="%s")
np.savetxt(f'./weights/c1_bias_float.txt',c1_bias,fmt="%s")
np.savetxt(f'./weights/c1_weight.txt',c1_weight_hex,fmt="%s")
np.savetxt(f'./weights/c1_weight_float.txt',c1_weight,fmt="%s")


#get c3 weight and bias
c3_weight = model._modules['c3'].weight.cpu().detach().numpy()
c3_bias = model._modules['c3'].bias.cpu().detach().numpy()

c3_weight_hex = np.zeros([16,6,5,5], dtype='<U4')
c3_bias_hex = np.zeros([16], dtype='<U4')

for i in range(16):
    c3_bias_hex[i] = struct.pack('>e', c3_bias[i]).hex()
    for l in range(6):
        for j in range(5):
            for k in range(5):
                c3_weight_hex[i,l,j,k] = struct.pack('>e', c3_weight[i,l,j,k]).hex()

c3_weight_hex = c3_weight_hex.reshape((c3_weight_hex.shape[0]*c3_weight_hex.shape[1]*c3_weight_hex.shape[2]),c3_weight_hex.shape[3])
c3_weight = c3_weight.reshape((c3_weight.shape[0]*c3_weight.shape[1]*c3_weight.shape[2]),c3_weight.shape[3])

np.savetxt(f'./weights/c3_bias.txt',c3_bias_hex,fmt="%s")
np.savetxt(f'./weights/c3_weight.txt',c3_weight_hex,fmt="%s")
np.savetxt(f'./weights/c3_bias_float.txt',c3_bias,fmt="%s")
np.savetxt(f'./weights/c3_weight_float.txt',c3_weight,fmt="%s")
'''
'''#get c5 weight and bias
c5_weight = model._modules['c5'].weight.cpu().detach().numpy()
c5_bias = model._modules['c5'].bias.cpu().detach().numpy()

c5_weight_hex = np.zeros([120,16,5,5], dtype='<U4')
c5_bias_hex = np.zeros([120], dtype='<U4')

for i in range(120):
    c5_bias_hex[i] = struct.pack('>e', c5_bias[i]).hex()
    for l in range(16):
        for j in range(5):
            for k in range(5):
                c5_weight_hex[i,l,j,k] = struct.pack('>e', c5_weight[i,l,j,k]).hex()

c5_weight_hex = c5_weight_hex.reshape((c5_weight_hex.shape[0]*c5_weight_hex.shape[1]*c5_weight_hex.shape[2]),c5_weight_hex.shape[3])
c5_weight = c5_weight.reshape((c5_weight.shape[0]*c5_weight.shape[1]*c5_weight.shape[2]),c5_weight.shape[3])

np.savetxt(f'./weights/c5_bias.txt',c5_bias_hex,fmt="%s")
np.savetxt(f'./weights/c5_weight.txt',c5_weight_hex,fmt="%s")
np.savetxt(f'./weights/c5_bias_float.txt',c5_bias,fmt="%s")
np.savetxt(f'./weights/c5_weight_float.txt',c5_weight,fmt="%s")

#get f6 weight and bias
f6_weight = model._modules['f6'].weight.cpu().detach().numpy()
f6_bias = model._modules['f6'].bias.cpu().detach().numpy()

f6_weight_hex = np.zeros([84,120], dtype='<U4')
f6_bias_hex = np.zeros([120], dtype='<U4')

for i in range(84):
    f6_bias_hex[i] = struct.pack('>e', f6_bias[i]).hex()
    for j in range(120):
        f6_weight_hex[i,j] = struct.pack('>e',f6_weight[i,j]).hex()

np.savetxt(f'./weights/f6_bias.txt',f6_bias_hex,fmt="%s")
np.savetxt(f'./weights/f6_weight.txt',f6_weight_hex,fmt="%s")
np.savetxt(f'./weights/f6_bias_float.txt',f6_bias,fmt="%s")
np.savetxt(f'./weights/f6_weight_float.txt',f6_weight,fmt="%s")

#get f6 weight and bias
output_weight = model._modules['output'].weight.cpu().detach().numpy()
output_bias = model._modules['output'].bias.cpu().detach().numpy()

output_weight_hex = np.zeros([10,84], dtype='<U4')
output_bias_hex = np.zeros([10], dtype='<U4')

for i in range(10):
    output_bias_hex[i] = struct.pack('>e', output_bias[i]).hex()
    for j in range(84):
        output_weight_hex[i,j] = struct.pack('>e',output_weight[i,j]).hex()

np.savetxt(f'./weights/output_bias.txt',output_bias_hex,fmt="%s")
np.savetxt(f'./weights/output_weight.txt',output_weight_hex,fmt="%s")
np.savetxt(f'./weights/output_bias_float.txt',output_bias,fmt="%s")
np.savetxt(f'./weights/output_weight_float.txt',output_weight,fmt="%s")