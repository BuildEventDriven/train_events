## **⚙️ Setup the Environment**

This script initializes the environment for projects requiring **Kafka, Flink, and Argo** on **Google Cloud Platform (GCP)**.  

---

### **💡 Customization**
- If you are using **AWS, Azure, or another cloud provider**, modify the cloud installation settings accordingly.  
- Manual changes will be required for compatibility with your chosen cloud provider.  

---

### **🔧 Run the Setup Script**
Ensure you have execution permissions before running the script:  

```sh
chmod +x setup_env.sh
./setup_env.sh
```
---

## **⚙️ Environment Requirements**

Ensure that both **GitHub CI/CD builds** and **remote compute instances** run on the following environment:

🔹 **Ubuntu 22.04 LTS Minimal**  
   - **Architecture:** x86_64 (amd64)  
   - **Build Version:** _jammy minimal image built on 2025-02-28_  

### **🔄 CI/CD Build Configuration**
- The **`ci-cd-pipeline.yml`** file enforces GitHub Actions to use `ubuntu-22.04` for CI/CD validation.  

### **💡 Remote Compute Setup**
- If you are using **a different environment**, ensure that GitHub builds are tested with the modified image.
- **For compatibility**, test the new environment as a **container** before deployment.  

---

## **⚠️ Alerts**
🚨 **Do not manually create a `.gitignore` file while creating a repo on UI**  
- The **`setup_repo.sh`** script automatically handles `.gitignore` setup.  
- Manually creating it may cause conflicts with the repository structure.  