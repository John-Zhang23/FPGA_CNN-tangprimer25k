import torch
from dataset import Mnistdataset

train_dataloader,test_dataloader = Mnistdataset()
model = torch.load("./model/LeNet5.pth").to("cpu")

correct = 0
total = 0

with torch.no_grad():
    for images, labels in test_dataloader:
        outputs = model(images)
        _, predicted = torch.max(outputs, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f"Accuracy on test set for float32: {100 * correct / total}%")


qat_model = torch.load('./model/LeNet5_qat.pth')
quantized_model = torch.ao.quantization.convert(qat_model.eval())
correct_qat = 0
total_qat = 0
with torch.no_grad():
    for images_qat, labels_qat in test_dataloader:
        outputs_qat = quantized_model(images_qat)
        _, predicted_qat = torch.max(outputs_qat, 1)
        total_qat += labels_qat.size(0)
        correct_qat += (predicted_qat == labels_qat).sum().item()

print(f"Accuracy on test set for int8: {100 * correct_qat / total_qat}%")
