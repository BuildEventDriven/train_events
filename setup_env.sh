#!/bin/bash

# Exit on error
set -e

# Define virtual environment directory
VENV_DIR="venv"

echo "Setting up virtual environment..."
# Create virtual environment if not exists
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv $VENV_DIR
fi

# Activate virtual environment
source $VENV_DIR/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

echo "Pre-installing required build dependencies..."
pip install numpy pytest setuptools wheel

echo "Installing local development & testing libraries..."
pip install \
    pytest \
    black \
    ruff \
    mypy \
    ipython \
    pre-commit \
    direnv

echo "Installing GCP-specific libraries..."
pip install \
    google-cloud-cli \
    google-cloud-storage \
    google-cloud-pubsub \
    google-cloud-bigquery \
    google-cloud-secret-manager \
    google-auth \
    google-auth-oauthlib

echo "Installing AI/ML & streaming tools..."
pip install \
    kafka-python \
    apache-flink \
    tensorflow \
    mlflow \
    whylogs \
    grpcio \
    shap \
    alibi \
    feast \
    xgboost \
    scikit-learn \
    onnxruntime

echo "Setting up pre-commit hooks..."
pre-commit install

echo "Running Ruff Linter to verify installation..."
python -m ruff check .

echo "Configuring direnv for automatic venv activation..."
echo "source venv/bin/activate" > .envrc
direnv allow

echo "Sourcing .envrc to ensure venv activation..."
source .envrc

echo "Adding development aliases..."
echo 'alias py="python3"' >> ~/.bashrc
echo 'alias venv-act="source venv/bin/activate"' >> ~/.bashrc
source ~/.bashrc

echo "Virtual environment setup complete!"
echo "Next steps:"
echo "   - Run 'source venv/bin/activate' to enter the virtual environment"
echo "   - Use 'pre-commit run --all-files' to test hooks"
