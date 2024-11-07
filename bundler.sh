#!/bin/bash

MODEL_FILE="model.pt"
INFERENCE_FILE="inference.py"
REQ_FILE="requirements.txt"
TMP_DIR=$(mktemp -d)
BUNDLE_NAME="model_bundle.tar.gz"

mkdir -p $TMP_DIR/code/

cp "$MODEL_FILE" "$TMP_DIR/"
cp "$INFERENCE_FILE" "$TMP_DIR/code/"
cp "$REQ_FILE" "$TMP_DIR/code/"

cd "$TMP_DIR"

echo "Creating SageMaker model bundle..."
tar -czf "$BUNDLE_NAME" *

mv "$BUNDLE_NAME" "$OLDPWD"

echo "Cleaning up temporary directory..."
rm -rf "$TMP_DIR"

if [ -f "$OLDPWD/$BUNDLE_NAME" ]; then
    echo "Model bundle created successfully: $OLDPWD/$BUNDLE_NAME"
else
    echo "Error: Model bundle creation failed."
    exit 1
fi

