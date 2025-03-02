# **Training ML/AI with an Event-Driven Ecosystem**

It leverages **Kafka, Flink, Argo CD, and GitHub Actions** to streamline model deployment, scaling, and monitoring.

---

## **🚀 Quick Start**

### **1️⃣ Clone the repository to your local machine.**
Ensure you have the required permissions before running the setup scripts.

```sh
git clone https://github.com/BuildEventDriven/train_events.git
cd train_events
```

### **2️⃣ Setup the Environment**
Initialize the environment variables and dependencies.

```sh
chmod +x setup_env.sh
./setup_env.sh
```
Once done!
- source venv/bin/activate to enter the virtual environment
- pre-commit run --all-files to test hooks

🚨 **Mac OS Required**
- This setup is designed to run on **Mac OS**.
- If you are using a different OS, you may encounter issues with the following dependencies:
  - `direnv`
  - `google-cloud-cli`
  - `apache-flink`
  Removed for now:
  - `kafka-python`
      - It requires tensorflow and tensorflow requires python version to between 3.18 and 3.11. Make sure to install appropriate python version at the beginning of the script. And, also force virtual-environment to use whichever version you install.
      - Skip this package and tensorflow as a whole.
  - `alibi`

🔧 **Fix:**
- Review and modify the **`setup_env.sh`** file manually to adjust for your operating system.

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
