# train_events
Training ML/AI with an event-driven ecosystem

Change directory to to root/
sh: chmod +x setup_repo.sh
sh: ./setup_repo.sh


CI/CD Mapping: 
.github/workflows/ci-cd-pipeline.yml  # GitHub Actions workflows stay here

ci-cd/
 ├── argo-cd/  
 │   ├── deployment.yaml  # Argo CD deployment flows
 │   ├── application.yaml  # Argo app definitions (optional)
 │   ├── sync-cronjob.yaml  # Auto-sync Argo apps (optional)
 │
 ├── kubeflow-pipelines/  
 │   ├── pipeline.yaml  # Kubeflow ML pipeline definitions
 │   ├── schedule.yaml  # Pipeline automation via Argo/Kubeflow
 │
 ├── server-ci-cd/  
 │   ├── compute-scaler.yaml  # Auto-scaling GCP compute nodes
 │   ├── broker-restart.yaml  # Restart Kafka brokers when needed
 │   ├── monitoring-flows.yaml  # Trigger monitoring jobs (Grafana, WhyLogs)
