# Project Directory Structure

This repository contains a well-structured directory for managing Kafka-based AI/ML workflows. Below is the organized directory structure with descriptions.

```
📦 project-root
├── 📂 infra                   # Infrastructure setup scripts
│   ├── 📄 instance-creation.sh   # Script to create compute instances
│   ├── 📄 kafka-setup.sh         # Kafka cluster setup script
│   ├── 📄 zookeeper-setup.sh     # Zookeeper setup script
│   ├── 📄 monitoring-setup.sh    # Monitoring setup script
├── 📂 terraform-scripts        # Terraform scripts for provisioning cloud resources
├── 📂 kubernetes-manifests     # Kubernetes YAML manifests for deployments
├── 📂 kafka                   # Kafka producer/consumer scripts and configurations
│   ├── 📄 producer.py            # Kafka producer script
│   ├── 📄 consumer.py            # Kafka consumer script
│   ├── 📄 topics-config.json     # Kafka topic configurations
├── 📂 schema-registry          # Schema definitions for Kafka message serialization
├── 📂 ingestion                # Data ingestion pipelines
│   ├── 📄 flink-data-quality.py  # Flink script for data quality checks
│   ├── 📄 spark-batch-ingestion.py # Spark batch ingestion script
├── 📂 kafka-connect-config     # Configuration for Kafka Connect integration
├── 📂 model-training           # Machine learning model training pipeline
│   ├── 📄 train_model.py        # ML model training script
│   ├── 📄 preprocess_data.py    # Data preprocessing script
├── 📂 mlflow-tracking          # MLflow tracking for experiments and logging
├── 📂 inference                # Inference pipelines for real-time and batch predictions
│   ├── 📄 real-time-inference.py  # Real-time inference script
│   ├── 📄 batch-inference.py     # Batch inference script
├── 📂 grpc-serving             # gRPC-based model serving setup
├── 📂 monitoring               # Monitoring configurations and dashboards
│   ├── 📄 prometheus-config.yml  # Prometheus configuration
│   ├── 📄 grafana-dashboard.json # Grafana dashboard setup
│   ├── 📄 whylogs-monitoring.py  # WhyLogs monitoring script for ML models
├── 📂 ci-cd                    # CI/CD pipeline setup
│   ├── 📂 github-actions       # GitHub Actions workflows
│   │   ├── 📄 ci-cd-pipeline.yml  # CI/CD workflow for GitHub Actions
│   ├── 📂 argo-cd             # ArgoCD GitOps configuration
│   │   ├── 📄 deployment.yaml    # ArgoCD deployment configuration
│   ├── 📂 kubeflow-pipelines  # Kubeflow pipelines for ML workflows
│   │   ├── 📄 pipeline.yaml      # Kubeflow pipeline definition
├── 📂 docs                     # Documentation and guides
│   ├── 📄 architecture-diagram.png  # System architecture diagram
│   ├── 📄 README.md                 # Project README
│   ├── 📄 setup-guide.md             # Setup instructions
├── 📂 scripts                  # Utility scripts
│   ├── 📄 data-simulator.py       # Script to simulate data
│   ├── 📄 benchmark-tests.py      # Performance benchmarking script
├── 📂 terraform-scripts        # Terraform scripts for cloud infrastructure
│   ├── 📄 main.tf              # Defines VM, networking, storage
│   ├── 📄 variables.tf         # Configurable Terraform variables
│   ├── 📄 outputs.tf           # Outputs from Terraform execution
│   ├── 📄 terraform.tfvars     # Default values for variables
│   ├── 📄 provider.tf          # Google Cloud provider setup
├── 📂 .github/workflows        # GitHub Actions workflow directory
│   ├── 📄 ci-cd-pipeline.yml      # Workflow for CI/CD
├── 📄 .gitignore                # Files and directories to be ignored by Git
├── 📄 README.md                 # Main project README
```

## Description
Each directory serves a specific purpose:

- **infra**: Scripts for setting up Kafka, Zookeeper, and monitoring.
- **terraform-scripts**: Terraform infrastructure as code (IaC) configurations.
- **kubernetes-manifests**: YAML files for Kubernetes deployments.
- **kafka**: Producer and consumer implementations for event streaming.
- **schema-registry**: Manages Avro schemas for message serialization.
- **ingestion**: Flink and Spark-based data ingestion pipelines.
- **kafka-connect-config**: Configurations for Kafka Connect integrations.
- **model-training**: ML model training and data preprocessing.
- **mlflow-tracking**: Experiment tracking using MLflow.
- **inference**: Real-time and batch inference scripts.
- **grpc-serving**: gRPC-based model serving infrastructure.
- **monitoring**: Prometheus, Grafana, and WhyLogs configurations.
- **ci-cd**: Continuous integration and deployment workflows.
- **docs**: Documentation and guides for system setup.
- **scripts**: Utility scripts for data simulation and benchmarking.

This structure ensures a modular, scalable, and maintainable approach to managing Kafka-based AI/ML workflows.
