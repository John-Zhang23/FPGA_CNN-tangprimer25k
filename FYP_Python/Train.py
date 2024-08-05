import torch
from torch import nn
from LeNet5 import LeNet
from torch.optim import lr_scheduler
from dataset import Mnistdataset
import os

torch.backends.cudnn.enabled = False
# set device
device = (
    "cuda"
    if torch.cuda.is_available()
    else "mps"
    if torch.backends.mps.is_available()
    else "cpu"
)
print(f"Using {device} device")

model = LeNet().to(device)

#define a loss function
loss_fn = nn.CrossEntropyLoss()

#define a optimizer
optimizer = torch.optim.SGD(model.parameters(), lr=1e-3, momentum=0.9)

#define  learning rate
lr_scheduler = lr_scheduler.StepLR(optimizer, step_size=10, gamma=0.1)

#define traning function
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

train_dataloader,test_dataloader = Mnistdataset()

epoch = 10
min_acc = 0
for t in range(epoch):
    print(f'epoch{t + 1}\n--------------')
    train(train_dataloader, model, loss_fn, optimizer,device=device)
    a = test(test_dataloader, model, loss_fn,device=device)
    if a > min_acc:

        folder = 'model'
        if not os.path.exists(folder):
            os.mkdir('model')
        min_acc = a
        print('save best model')
        torch.save(model, 'model/LeNet5.pth')
        torch.save(model.state_dict(),'model/LeNet5_state_dict.pth')

print('Done')
