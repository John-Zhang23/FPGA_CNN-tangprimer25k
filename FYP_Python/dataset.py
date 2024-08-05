from torchvision import datasets, transforms
import torch
import matplotlib.pyplot as plt
class Binarize:
    def __init__(self, threshold=0.4):
        self.threshold = threshold
    def __call__(self, img):
        return (img > self.threshold).float()
class Invert:
    def __call__(self, img):
        return transforms.functional.invert(img)
def Mnistdataset(train_batch=16, test_batch=16):
    # Data transform 2 tensor
    data_transform_inverse = transforms.Compose([
        transforms.ToTensor(),
        transforms.RandomRotation(degrees=45),
        Binarize(),
        Invert()
    ])
    data_transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.RandomRotation(degrees=45),
        Binarize()
    ])
    train_dataset_rotated = datasets.MNIST(root='./data', train=True, transform=data_transform, download=True)
    test_dataset_rotated = datasets.MNIST(root='./data', train=False, transform=data_transform, download=True)
    train_dataset_rotated_inverse = datasets.MNIST(root='./data', train=True, transform=data_transform_inverse, download=True)
    test_dataset_rotated_inverse = datasets.MNIST(root='./data', train=False, transform=data_transform_inverse, download=True)
    train_concat_data = torch.utils.data.ConcatDataset([train_dataset_rotated, train_dataset_rotated_inverse])
    test_concat_data = torch.utils.data.ConcatDataset([test_dataset_rotated, test_dataset_rotated_inverse])
    train_dataloader = torch.utils.data.DataLoader(dataset=train_concat_data, batch_size=train_batch, shuffle=True)
    test_dataloader = torch.utils.data.DataLoader(dataset=test_concat_data, batch_size=test_batch, shuffle=True)
    return train_dataloader,test_dataloader
#
# train_dataloader,test_dataloader = Mnistdataset(train_batch=16, test_batch=16)
#
# examples = enumerate(test_dataloader)
# batch_idx, (imgs, labels) = next(examples)
# fig = plt.figure()
# for i in range(16):
#     plt.subplot(4, 4, i + 1)
#     plt.tight_layout()
#     plt.imshow(imgs[i][0], cmap='gray', interpolation='none')
#     plt.title("label: {}".format(labels[i]))
#     plt.xticks([])
#     plt.yticks([])
# plt.show()
