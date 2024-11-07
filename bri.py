import torch
import torch.nn as nn
import torch.optim as optim

class SimpleModel(nn.Module):
    """
    A simple neural network model with one hidden layer and ReLU activation.
    """
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.fc1 = nn.Linear(1, 10)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(10, 1)

    def forward(self, x):
        return self.fc2(self.relu(self.fc1(x)))

# Initialize the model, loss function, and optimizer
model = SimpleModel()
criterion = nn.MSELoss()  # Use MSELoss for regression or BCELoss for binary classification
optimizer = optim.SGD(model.parameters(), lr=0.01)

# Save the trained model's state dictionary
torch.save(model.state_dict(), "model.pt")

