# Deployment Fix and Tool Installation TODO

## 1. Fix YAML Configuration Issues
- [x] Split `provider-grafana.yaml` into separate files (provider.yaml and dashboard.yaml)
- [x] Validate YAML syntax for all configuration files

## 2. Install Required Deployment Tools
- [x] Install Ansible for Windows
- [x] Install kubectl for Windows
- [x] Install Crossplane CLI
- [x] Install yamllint for YAML validation
- [x] Create installation scripts for easy setup

## 3. Fix Grafana Configuration Issues
- [x] Diagnose and fix 500 errors in local Grafana instance
- [x] Update Grafana environment variables
- [x] Test Grafana API endpoints

## 4. Test Deployment Configurations
- [x] Test Ansible playbook syntax
- [x] Test Kubernetes manifests
- [x] Test Docker deployment locally
- [x] Validate Crossplane configurations

## 5. Create Working Deployment Scripts
- [x] Create Docker deployment script
- [x] Create Kubernetes deployment script
- [x] Create cloud platform deployment scripts (Heroku, Render, Fly.io)
- [x] Add deployment validation checks

## 6. Documentation and Testing
- [x] Update deployment guides with working commands
- [x] Create comprehensive testing scripts
- [x] Document troubleshooting steps
