import torch
from torch import nn
from torch.ao.quantization import QuantStub, DeQuantStub
# LeNet-5网络模型
class LeNet(nn.Module):
    def __init__(self):
        super(LeNet,self).__init__()
        self.quant = QuantStub()
        self.c1 = nn.Conv2d(in_channels=1, out_channels=6, kernel_size=5, padding=2,bias=False)
        self.Relu1 = nn.ReLU()
        self.s2 = nn.AvgPool2d(kernel_size=2, stride=2)
        self.c3 = nn.Conv2d(in_channels=6, out_channels=16, kernel_size=5,bias=False)
        self.Relu2 = nn.ReLU()
        self.s4 = nn.AvgPool2d(kernel_size=2, stride=2)
        self.c5 = nn.Conv2d(in_channels=16, out_channels=120, kernel_size=5,bias=False)
        self.flatten = nn.Flatten()
        self.f6 = nn.Linear(120, 84,bias=False)
        self.output = nn.Linear(84, 10,bias=False)
        self.dequant = DeQuantStub()
    def forward(self, x):
        x = self.quant(x)
        x = self.c1(x)
        x = self.Relu1(x)
        x = self.s2(x)
        x = self.c3(x)
        x = self.Relu2(x)
        x = self.s4(x)
        x = self.c5(x)
        x = self.flatten(x)
        x = self.f6(x)
        x = self.output(x)
        x = self.dequant(x)
        return x

print (LeNet)