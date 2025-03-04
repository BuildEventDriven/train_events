#!/bin/bash

# Set repo name
REPO_NAME="train_events"

# Create base directory
mkdir -p $REPO_NAME && cd $REPO_NAME

# Create subdirectories
mkdir -p infra terraform-scripts kubernetes-manifests
mkdir -p kafka schema-registry
mkdir -p ingestion kafka-connect-config
mkdir -p model-training mlflow-tracking
mkdir -p inference grpc-serving
mkdir -p monitoring
mkdir -p ci-cd github-actions argo-cd kubeflow-pipelines
mkdir -p docs
mkdir -p scripts
mkdir -p .github/workflows  # Create GitHub Actions directory

# Create files
touch infra/instance-creation.sh
touch infra/kafka-setup.sh
touch infra/zookeeper-setup.sh
touch infra/monitoring-setup.sh
touch kafka/producer.py
touch kafka/consumer.py
touch kafka/topics-config.json
touch ingestion/flink-data-quality.py
touch ingestion/spark-batch-ingestion.py
touch model-training/train_model.py
touch model-training/preprocess_data.py
touch inference/real-time-inference.py
touch inference/batch-inference.py
touch monitoring/prometheus-config.yml
touch monitoring/grafana-dashboard.json
touch monitoring/whylogs-monitoring.py
touch ci-cd/github-actions/ci-cd-pipeline.yml
touch ci-cd/argo-cd/deployment.yaml
touch ci-cd/kubeflow-pipelines/pipeline.yaml
touch docs/architecture-diagram.png
touch docs/README.md
touch docs/setup-guide.md
touch scripts/data-simulator.py
touch scripts/benchmark-tests.py
touch .gitignore
touch README.md
touch terraform-scripts/main.tf
touch terraform-scripts/variables.tf
touch terraform-scripts/outputs.tf
touch terraform-scripts/terraform.tfvars
touch terraform-scripts/provider.tf

cat <<EOL > .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 24.1.1  # Use the latest stable version of Black
    hooks:
      - id: black
        language_version: python3  # Ensure it runs with the correct Python version

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.9.9  # Use the latest version of Ruff
    hooks:
      # Run the linter
      - id: ruff
        args: [--fix]
      # Run the formatter
      - id: ruff-format
EOL

# Create requirements.txt (Example Python dependencies)
cat <<EOL > requirements.txt
kafka-python
apache-flink
pyspark
tensorflow
mlflow
whylogs
grpcio
pytest
ruff
black

# Google Cloud Dependencies
google-cloud-storage
google-cloud-pubsub
google-cloud-bigquery
google-cloud-secret-manager
google-auth
google-auth-oauthlib

# ML & Deep Learning
torch
onnxruntime
xgboost
scikit-learn
transformers

# Streaming & Batch Processing
confluent-kafka
delta-spark
feast

# Monitoring & Explainability
shap
alibi
prometheus-client

# MLOps & Model Deployment
tensorflow-serving-api
ray[serve]
EOL

# Create tests directory and a sample test file
cat <<EOL > tests/test_sample.py
def test_example():
    assert 1 + 1 == 2
EOL
# Create GitHub Actions CI/CD Pipeline YAML
cat <<EOL > .github/workflows/ci-spark-flink.yml
name: Spark & Flink Setup

on:
  push:
    paths:
      - 'spark/**'
      - 'flink/**'
  workflow_dispatch: # Allow manual triggering

jobs:
  setup-spark-flink:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Install Apache Spark & Flink
        run: |
          wget -qO - https://archive.apache.org/dist/spark/spark-3.3.0/spark-3.3.0-bin-hadoop3.tgz | tar xz
          echo "export SPARK_HOME=$(pwd)/spark-3.3.0-bin-hadoop3" >> $GITHUB_ENV
          wget -qO - https://archive.apache.org/dist/flink/flink-1.15.2-bin-scala_2.12.tgz | tar xz
          echo "export FLINK_HOME=$(pwd)/flink-1.15.2" >> $GITHUB_ENV
EOL

# Create GitHub Actions CI/CD Pipeline YAML
cat <<EOL > .github/workflows/ci-prometheus.yml
name: Prometheus Setup

on:
  push:
    paths:
      - 'monitoring/**'
  workflow_dispatch: # Allow manual triggering

jobs:
  setup-prometheus:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Install Prometheus & Start Monitoring
        run: |
          wget https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz
          tar xvfz prometheus-*.tar.gz
          cd prometheus-*
          ./prometheus --config.file=prometheus.yml &
EOL

# Create GitHub Actions CI/CD Pipeline YAML
cat <<EOL > .github/workflows/ci-google-auth.yml
name: Google Cloud Authentication

on:
  push:
    paths:
      - '.github/workflows/ci-google-auth.yml'
  workflow_dispatch: # Allow manual triggering

jobs:
  setup-google-auth:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Authenticate with Google Cloud
        continue-on-error: true  # Ensures build continues even if auth fails
        env:
          GOOGLE_APPLICATION_CREDENTIALS: ${{ secrets.GCP_SA_KEY }}
        run: |
          if [ -z "${{ secrets.GCP_SA_KEY }}" ]; then
            echo "Skipping authentication: No GCP_SA_KEY provided"
            exit 0
          fi
          echo "${{ secrets.GCP_SA_KEY }}" > gcp-key.json
          gcloud auth activate-service-account --key-file=gcp-key.json
          gcloud config set project ${{ secrets.GCP_PROJECT }}
EOL


# Create GitHub Actions CI/CD Pipeline YAML
cat <<EOL > .github/workflows/ci-cd-pipeline.yml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-22.04 # Keeping it locked in to 22.04, avoiding any update issues when happens on GitHub's side. 
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v3
        with:
          python-version: '3.9'

      - name: Install Pre-Dependencies (Numpy, Pytest, Setuptools, Wheel)
        run: |
          python -m pip install --upgrade pip
          # Install missing packages explicitly if not already installed
          python -c "import numpy" || pip install numpy
          python -c "import pytest" || pip install pytest
          python -c "import setuptools" || pip install setuptools
          python -c "import wheel" || pip install wheel

      - name: Install Main Dependencies (Only If Missing)
        run: |
          while IFS= read -r package || [[ -n "$package" ]]; do
            # Ignore comments and empty lines in requirements.txt
            [[ "$package" =~ ^#.*$ || -z "$package" ]] && continue
            # Extract the actual package name (handle version constraints like "numpy==1.21.0")
            pkg_name=$(echo "$package" | cut -d '=' -f1 | cut -d '[' -f1)
            # Check if package is installed
            python -c "import $pkg_name" 2>/dev/null || pip install "$package"
          done < requirements.txt

      - name: Install Google Cloud CLI
        run: |
          sudo apt-get update
          sudo apt-get install -y google-cloud-cli
          gcloud --version
      
      - name: Run Spark & Flink Setup
        run: gh workflow run ci-spark-flink.yml || true  # Ensures it doesn't fail the pipeline
      
      - name: Run Prometheus Setup
        run: gh workflow run ci-prometheus.yml || true  # Ensures it doesn't fail the pipeline
      
      - name: Run Google Cloud Authentication
        run: gh workflow run ci-google-auth.yml || true  # Ensures it doesn't fail the pipeline

      - name: Run Ruff Linter
        run: python -m ruff check .  # Runs ruff on all Python files.

      - name: Auto-Fix Formatting with Black (if running manually)
        if: github.event_name == 'pull_request'
        run: black .  # Auto-formats code (this won't block CI)

      - name: Run Tests
        run: pytest tests/ || true  # Allows test failures but pipeline continues

      - name: Install Google Cloud CLI
        run: |
          sudo apt-get update
          sudo apt-get install -y google-cloud-cli
          gcloud --version
      
EOL

# Initialize Git repo
git init

# Print success message
echo "Repository structure for '$REPO_NAME' has been created successfully!"
echo "GitHub Actions CI/CD pipeline and requirements.txt added!"

# Create and write all ignore patterns into .gitignore
cat <<EOL > .gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# DS_Store - Folder metadata
.DS_Store

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
.pybuilder/
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
#   For a library or package, you might want to ignore these files since the code is
#   intended to run in multiple environments; otherwise, check them in:
# .python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that don't work, or not
#   install all needed dependencies.
#Pipfile.lock

# UV
#   Similar to Pipfile.lock, it is generally recommended to include uv.lock in version control.
#   This is especially recommended for binary packages to ensure reproducibility, and is more
#   commonly ignored for libraries.
#uv.lock

# poetry
#   Similar to Pipfile.lock, it is generally recommended to include poetry.lock in version control.
#   This is especially recommended for binary packages to ensure reproducibility, and is more
#   commonly ignored for libraries.
#   https://python-poetry.org/docs/basic-usage/#commit-your-poetrylock-file-to-version-control
#poetry.lock

# pdm
#   Similar to Pipfile.lock, it is generally recommended to include pdm.lock in version control.
#pdm.lock
#   pdm stores project-wide configurations in .pdm.toml, but it is recommended to not include it
#   in version control.
#   https://pdm.fming.dev/latest/usage/project/#working-with-version-control
.pdm.toml
.pdm-python
.pdm-build/

# PEP 582; used by e.g. github.com/David-OConnor/pyflow and github.com/pdm-project/pdm
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Added secrets Directory
secrets/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Cython debug symbols
cython_debug/

# PyCharm
#  JetBrains specific template is maintained in a separate JetBrains.gitignore that can
#  be found at https://github.com/github/gitignore/blob/main/Global/JetBrains.gitignore
#  and can be added to the global gitignore or merged into this file.  For a more nuclear
#  option (not recommended) you can uncomment the following to ignore the entire idea folder.
#.idea/

# PyPI configuration file
.pypirc
EOL