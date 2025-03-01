# **Training ML/AI with an Event-Driven Ecosystem**

It leverages **Kafka, Flink, Argo CD, and GitHub Actions** to streamline model deployment, scaling, and monitoring.

---

## **🚀 Quick Start**

### **1️⃣ Setup the Repository**
Ensure you have the required permissions before running the setup scripts.

```sh
chmod +x setup_repo.sh
./setup_repo.sh
```

### **2️⃣ Setup the Environment**
Initialize the environment variables and dependencies.

```sh
chmod +x setup_env.sh
./setup_env.sh
```

---

## **📌 CI/CD Pipeline Overview**
## Active
This repository uses **GitHub Actions**

### **🔄 CI/CD Workflow Mapping**
- **GitHub Actions Workflows**  
  - Located in: `.github/workflows/ci-cd-pipeline.yml`
  - Manages code integration, testing, and deployment.
  - It triggers tool-specific pipelines: 
  		- .github/workflows/ci-google-auth.yml
  		- .github/workflows/ci-prometheus.yml
  		- .github/workflows/ci-spark-flink.yml
---

## **📌 Contribution Guidelines**
- Fork the repository.
- Create a new branch (`feature-branch`).
- Commit changes and push them.
- Submit a pull request.

---

## **🔧 Troubleshooting**
If you encounter any issues, check the logs or raise an issue in the repository.

---

## **👨‍💻 Maintainers**
- **Karan Patel** - _Primary Maintainer_  
- **Other Contributors** - LOOKING FOR SOME LOVE :D  

For queries, open an issue or reach out via email. 
Email: buildeventdriven@gmail.com
