import torch
from dataset import Mnistdataset

device = "cpu"

qat_model = torch.load('./model/LeNet5_qat.pth')

# def quantize_tensor(tensor, scale, zero_point, dtype=torch.qint8):
#     qmin, qmax = -128, 127  # INT8 范围
#     quantized = torch.clamp(torch.round(tensor / scale + zero_point), qmin, qmax)
#     return quantized.to(dtype)

# scale, zero_point = quantized_model.quant.scale, quantized_model.quant.zero_point

train_dataloader,test_dataloader = Mnistdataset()

correct = 0
total = 0

with torch.no_grad():
    for images, labels in test_dataloader:
        outputs = qat_model(images)
        _, predicted = torch.max(outputs, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f"Accuracy on test set for QAT: {100 * correct / total}%")