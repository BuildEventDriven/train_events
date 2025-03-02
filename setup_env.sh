#!/bin/bash

# Exit on error
set -e

echo "Ensuring Python 3.11 is installed..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y python3.11 python3.11-venv python3.11-dev
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python@3.11
fi

echo "Ensuring wget is installed..."
if ! command -v wget &> /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y wget
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install wget
    fi
fi


# Define virtual environment directory
VENV_DIR="venv"

echo "Setting up virtual environment..."
# Create virtual environment with Python 3.11
if [ ! -d "$VENV_DIR" ]; then
    python3.11 -m venv $VENV_DIR
fi

# Activate virtual environment
source $VENV_DIR/bin/activate

echo "Installing local development & testing libraries..."
pip install \
    pytest \
    black \
    ruff \
    mypy \
    ipython \
    pre-commit

echo "Upgrading pip..."
pip install --upgrade pip

echo "Pre-installing required build dependencies..."
pip install numpy pytest setuptools wheel

echo "Installing system dependencies..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update && sudo apt-get install -y direnv
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install direnv
fi

# GCP
echo "Installing GCP-specific libraries..."
pip install \
    google-cloud-storage \
    google-cloud-pubsub \
    google-cloud-bigquery \
    google-cloud-secret-manager \
    google-auth \
    google-auth-oauthlib

echo "Installing Google Cloud CLI..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update && sudo apt-get install -y google-cloud-cli
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install --cask google-cloud-sdk
fi

# KAFKA AND AI/ML
echo "Checking Python version..."
python --version

echo "Skipping local TensorFlow and Python Kafka installation since inference will run remotely."

if [[ "$IS_REMOTE_ENV" == "true" ]]; then
    echo "Installing TensorFlow and Python Kafka on remote compute..."
    if [[ "$(uname -m)" == "arm64" && "$OSTYPE" == "darwin"* ]]; then
        pip install tensorflow-macos tensorflow-metal
        pip install kafka-python
        pip install alibi


    else
        pip install tensorflow
    fi
fi

echo "Installing AI/ML & streaming tools..."

echo "Installing pre-requisites for building dependencies..."
# pip install setuptools wheel numpy cython

pip install \
    mlflow \
    whylogs \
    grpcio \
    shap \
    feast \
    xgboost \
    scikit-learn \
    onnxruntime \

echo "Installing Apache Flink..."
FLINK_VERSION="1.20.1"
FLINK_DIR="/opt/flink"

# Download and extract Flink
if [[ ! -d "$FLINK_DIR" ]]; then
    wget -q "https://dlcdn.apache.org/flink/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-scala_2.12.tgz"
    tar -xzf "flink-$FLINK_VERSION-bin-scala_2.12.tgz"
    sudo mv "flink-$FLINK_VERSION" "$FLINK_DIR"
    rm "flink-$FLINK_VERSION-bin-scala_2.12.tgz"
fi

# Add Flink to PATH
echo "export FLINK_HOME=$FLINK_DIR" >> ~/.bashrc
echo "export PATH=\$FLINK_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

echo "Apache Flink installed successfully."


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
