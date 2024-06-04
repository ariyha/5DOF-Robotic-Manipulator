import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, TensorDataset, random_split


class AIRModel(nn.Module):
    def __init__(self):
        super(AIRModel, self).__init__()
        self.fc1 = nn.Linear(3, 32)
        self.fc2 = nn.Linear(32, 64)
        self.fc3 = nn.Linear(64, 128)
        self.fc4 = nn.Linear(128, 256)
        self.fc5 = nn.Linear(256, 128)
        self.fc6 = nn.Linear(128, 32)
        self.fc7 = nn.Linear(32, 3)
    
    def forward(self, x):
        x = torch.relu(self.fc1(x))
        x = torch.relu(self.fc2(x))
        x = torch.relu(self.fc3(x))
        x = torch.relu(self.fc4(x))
        x = torch.relu(self.fc5(x))
        x = torch.relu(self.fc6(x))
        x = self.fc7(x)  # Linear activation for the output layer
        return x

def main():
    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')  # Detect and choose device

    model = AIRModel().to(device)  # Move model to the chosen device
    model.load_state_dict(torch.load('PROJECT/model80deg400.pth', map_location=device))  # Load model with device-aware mapping

    dummy_input = torch.zeros(1,3).to(device)
    torch.onnx.export(model,dummy_input,'onnx_model.onnx',verbose=True)

main()