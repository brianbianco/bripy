
# Simple PyTorch Model for SageMaker Inference Pipeline

This project demonstrates how to create a simple PyTorch model, bundle it, and prepare it for deployment in an AWS SageMaker inference pipeline.

---

## Example Usage:

1. **Build the model and image**:
   ```bash
   make build
   ```

2. **Run and test the model**:
   ```bash
   make run_model
   ```

3. **Create the SageMaker bundle**:
   ```bash
   make artifact
   ```

---

## Model Explanation

The model is a simple linear regression network with one fully connected layer. It is trained to predict a value based on the equation:

```
y = 2 * x + 1
```

While the model itself is very basic and the output is not meaningful (since the data is randomly generated), it serves as a simple example of how to train, save, and deploy a model in AWS SageMaker.

---

## **Add the Model to SageMaker**

To create the model, use the `aws sagemaker create-model` CLI command. This assumes you have already uploaded your model bundle to an S3 bucket.

```bash
aws sagemaker create-model \
    --model-name bripy \
    --primary-container "Image=811664100460.dkr.ecr.us-west-2.amazonaws.com/sagemaker-pytorch:2.0.0-cpu-py3,ModelDataUrl=s3://<your-bucket-name>/model_bundle.tar.gz" \
    --execution-role-arn arn:aws:iam::<your-account-id>:role/<your-sagemaker-execution-role>
```

### Step 1: Create the Model Group

Run the following command to create a model group:

```bash
aws sagemaker create-model-package-group \
    --model-package-group-name bripy-model-group
```

## Adding the Model to a Model Group

```bash
aws sagemaker create-model-package \
    --model-package-name bripy-model-package \
    --model-name bripy \
    --model-package-group-name bripy-model-group
```

## Get the version of the model package

```
aws sagemaker list-model-packages --model-package-group-name bripy-model-group
```

## Approving the latest version

```bash
aws sagemaker update-model-package-group \
    --model-package-group-name bripy-model-group \
    --model-package-version 1 \
    --approval-status Approved
```
