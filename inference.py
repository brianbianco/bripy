import torch
import torch.nn as nn
import json

class SimpleModel(nn.Module):
    """
    A simple feedforward neural network model.
    """
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.fc1 = nn.Linear(1, 10)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(10, 1)

    def forward(self, x):
        return self.fc2(self.relu(self.fc1(x)))

def model_fn(model_dir):
    """
    Load and return the trained model from the specified directory.
    """
    model = SimpleModel()
    model.load_state_dict(torch.load(f"{model_dir}/model.pt", weights_only=True))
    model.eval()
    return model

def predict_fn(input_data, model):
    """
    Process input data and return the model prediction.
    """
    input_tensor = torch.tensor(input_data, dtype=torch.float32)
    output = model(input_tensor)
    return output.detach().numpy().tolist()

def test_local():
    """
    Test the model locally by simulating a SageMaker inference request.
    """
    model_dir = "."
    model = model_fn(model_dir)
    input_data = [[3.0]]
    prediction = predict_fn(input_data, model)
    print("Model Output:", prediction)

if __name__ == "__main__":
    test_local()

