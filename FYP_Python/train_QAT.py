import torch
from torch import nn
from torch.optim import lr_scheduler
from dataset import Mnistdataset
import os
import io
from LeNet5 import LeNet
device = ("cpu")
print(f"Using {device} device")

fuse_modules = [['c1', 'Relu1'],
                ['c3', 'Relu2']]


qat_model = torch.load("./model/LeNet5.pth").to(device)

#define a loss function
loss_fn = nn.CrossEntropyLoss()
#define a optimizer
optimizer = torch.optim.SGD(qat_model.parameters(),  lr=1e-3, momentum=0.9)
#define  learning rate
lr_scheduler = lr_scheduler.StepLR(optimizer, step_size=10, gamma=0.1)

#prepare Qat

weight_quant = torch.ao.quantization.fake_quantize.FakeQuantize.with_args(observer=torch.ao.quantization.observer.MinMaxObserver, quant_min=-127, quant_max=127,
                                                                    dtype=torch.qint8, qscheme=torch.per_tensor_symmetric, reduce_range=False)
activation_quant = torch.ao.quantization.fake_quantize.FakeQuantize.with_args(observer=torch.ao.quantization.observer.MinMaxObserver, quant_min=0, quant_max=255,
                                                                    dtype=torch.quint8, qscheme=torch.per_tensor_affine, reduce_range=False)
qat_model.eval()
qat_model.qconfig = torch.ao.quantization.qconfig.QConfig(activation=activation_quant,weight=weight_quant)
qat_model_fused = torch.ao.quantization.fuse_modules(qat_model,fuse_modules)
qat_model_prepared = torch.ao.quantization.prepare_qat(qat_model_fused.train())

train_dataloader,test_dataloader = Mnistdataset()

epoch = 3
min_acc = 0

def train(dataloader, model, loss_fn, optimizer,device):
    loss, current, n = 0.0, 0.0, 0
    model.train()
    for batch, (X, y) in enumerate(dataloader):
        #forward
        X, y = X.to(device), y.to(device)
        output = model(X)
        cur_loss = loss_fn(output, y)
        _, pred = torch.max(output, axis=1)

        cur_acc = torch.sum(y == pred) / output.shape[0]

        optimizer.zero_grad()
        cur_loss.backward()
        optimizer.step()

        loss += cur_loss.item()
        current += cur_acc.item()
        n += 1
    print("train_loss" + str(loss/n))
    print("train_acc" + str(current/n))


def test(dataloader, model, loss_fn, device):
    model.eval()
    loss, current, n = 0.0, 0.0, 0
    with torch.no_grad():
        for batch, (X, y) in enumerate(dataloader):
            X, y = X.to(device), y.to(device)
            output = model(X)
            cur_loss = loss_fn(output, y)
            _, pred = torch.max(output, axis=1)
            cur_acc = torch.sum(y == pred) / output.shape[0]
            loss += cur_loss.item()
            current += cur_acc.item()
            n += 1

        print("test_loss" + str(loss / n))
        print("test_acc" + str(current / n))

        return current / n



for t in range(epoch):
    print(f'epoch{t + 1}\n--------------')
    train(train_dataloader, qat_model_prepared, loss_fn, optimizer, device=device)
    test(test_dataloader, qat_model_prepared, loss_fn, device=device)
qat_model_prepared.eval()
qat_model_int8 = torch.ao.quantization.convert(qat_model_prepared)
# b = io.BytesIO()
# torch.save(qat_model_int8.state_dict(), b)

print(qat_model_int8)
print(qat_model_int8.c1.weight().int_repr())

print('Done')

