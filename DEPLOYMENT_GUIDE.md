# Multi-Platform Deployment Guide for Banking Dashboard

This Grafana-based banking dashboard can be deployed to multiple platforms. Follow the guides below:

---

## 🚀 Platform Deployment Options

### **Quick Start - Run All Tests First**
Before deploying, run the comprehensive test suite:
```powershell
# Run all deployment tests
.\run-all-deploy-tests.ps1

# Install required tools if needed
.\install-tools.ps1
```

### 1. **Local Docker Deployment** (Recommended for Testing)

#### Quick Deploy:
```powershell
# Deploy locally with Docker
.\deploy-docker.ps1
```
This will:
- Build the Docker image
- Start Grafana on http://localhost:3000
- Username: admin, Password: admin

#### Manual Docker Steps:
```bash
# Build and run
docker build -t owlbandocker/dashboard:latest .
docker run -d -p 3000:3000 -e GF_SECURITY_ADMIN_PASSWORD=admin owlbandocker/dashboard:latest
```

### 2. **Heroku Deployment** (Container-based)

#### Prerequisites:
- Heroku account verified with payment information
- Heroku CLI installed ✅
- Docker installed

#### Steps:
```bash
# Login to Heroku
heroku login

# Create app with container stack
heroku create your-app-name --stack container

# Login to Heroku Container Registry
heroku container:login

# Build and push Docker image
heroku container:push web -a your-app-name

# Release the image
heroku container:release web -a your-app-name

# Open the app
heroku open -a your-app-name
```

#### Set Environment Variables:
```bash
heroku config:set GF_SECURITY_ADMIN_PASSWORD=your_secure_password -a your-app-name
heroku config:set GF_SERVER_ROOT_URL=https://your-app-name.herokuapp.com -a your-app-name
```

---

### 2. **Vercel Deployment** (Already configured)

Your project has `.vercel/project.json` configured.

#### Steps:
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel

# For production
vercel --prod
```

**Note:** Vercel is optimized for static sites and serverless functions. For Grafana (which requires a persistent server), consider using Vercel for the frontend and another platform for Grafana backend.

---

### 3. **Docker Hub + Cloud Platforms**

#### Build and Push to Docker Hub:
```bash
# Login to Docker Hub
docker login

# Build image
docker build -t owlbandocker/dashboard:latest .

# Push to Docker Hub
docker push owlbandocker/dashboard:latest
```

#### Deploy to Various Platforms:

**a) AWS ECS (Elastic Container Service):**
```bash
# Install AWS CLI
# Configure AWS credentials
aws configure

# Create ECS cluster, task definition, and service
# Use the Docker image: owlbandocker/dashboard:latest
```

**b) Google Cloud Run:**
```bash
# Install gcloud CLI
gcloud auth login

# Deploy container
gcloud run deploy grafana-dashboard \
  --image owlbandocker/dashboard:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 3000
```

**c) Azure Container Instances:**
```bash
# Install Azure CLI
az login

# Create resource group
az group create --name grafana-rg --location eastus

# Deploy container
az container create \
  --resource-group grafana-rg \
  --name grafana-dashboard \
  --image owlbandocker/dashboard:latest \
  --dns-name-label grafana-banking \
  --ports 3000
```

---

### 4. **Kubernetes Deployment** (Using existing configs)

You already have `deployment.yaml` and `service.yaml` files.

#### Steps:
```bash
# Apply Kubernetes configurations
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Check deployment status
kubectl get deployments
kubectl get services

# Get external IP (for LoadBalancer service)
kubectl get service grafana-dashboard
```

#### For Minikube (local testing):
```bash
minikube start
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
minikube service grafana-dashboard
```

---

### 5. **Render.com Deployment**

#### Steps:
1. Go to https://render.com
2. Sign up/Login
3. Click "New +" → "Web Service"
4. Connect your GitHub repository
5. Configure:
   - **Environment:** Docker
   - **Dockerfile Path:** ./Dockerfile
   - **Port:** 3000
6. Click "Create Web Service"

---

### 6. **Railway.app Deployment**

#### Steps:
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Deploy
railway up

# Add domain
railway domain
```

---

### 7. **DigitalOcean App Platform**

#### Steps:
1. Go to https://cloud.digitalocean.com/apps
2. Click "Create App"
3. Connect GitHub repository
4. Select Dockerfile deployment
5. Configure:
   - **HTTP Port:** 3000
   - **Environment Variables:** Add Grafana configs
6. Deploy

---

### 8. **Fly.io Deployment**

#### Steps:
```bash
# Install flyctl
# Windows: iwr https://fly.io/install.ps1 -useb | iex

# Login
flyctl auth login

# Launch app
flyctl launch

# Deploy
flyctl deploy

# Open app
flyctl open
```

---

## 🔐 Security Recommendations

For all deployments, set these environment variables:

```bash
GF_SECURITY_ADMIN_PASSWORD=<strong-password>
GF_SECURITY_ADMIN_USER=admin
GF_SERVER_ROOT_URL=<your-app-url>
GF_INSTALL_PLUGINS=<any-required-plugins>
```

---

## 📊 Monitoring & Scaling

### Heroku:
```bash
heroku ps:scale web=2 -a your-app-name  # Scale to 2 dynos
heroku logs --tail -a your-app-name     # View logs
```

### Kubernetes:
```bash
kubectl scale deployment grafana-dashboard --replicas=3
kubectl logs -f deployment/grafana-dashboard
```

---

## 🔄 CI/CD Integration

### GitHub Actions (for automated deployments):

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Multiple Platforms

on:
  push:
    branches: [ main ]

jobs:
  deploy-heroku:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: akhileshns/heroku-deploy@v3.12.12
        with:
          heroku_api_key: ${{secrets.HEROKU_API_KEY}}
          heroku_app_name: "your-app-name"
          heroku_email: "your-email@example.com"
          usedocker: true

  deploy-docker-hub:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build and push Docker image
        run: |
          docker login -u ${{ secrets.DOCKER_USERNAME }} -p ${{ secrets.DOCKER_PASSWORD }}
          docker build -t owlbandocker/dashboard:latest .
          docker push owlbandocker/dashboard:latest
```

---

## 🎯 Quick Start Recommendations

**For Production Banking Dashboard:**
1. **Primary:** AWS ECS or Google Cloud Run (enterprise-grade, scalable)
2. **Backup:** Kubernetes cluster (for high availability)
3. **Development:** Heroku or Render.com (easy setup)

**Cost Considerations:**
- **Free Tier:** Render.com, Railway.app (limited)
- **Low Cost:** Fly.io, DigitalOcean
- **Enterprise:** AWS, Google Cloud, Azure

---

## 📝 Next Steps

1. Choose your primary deployment platform
2. Set up environment variables securely
3. Configure custom domain (if needed)
4. Set up SSL/TLS certificates
5. Configure backup and monitoring
6. Implement CI/CD pipeline

---

## 🆘 Troubleshooting

### Common Issues:

**Port Binding:**
- Ensure Grafana listens on `0.0.0.0:3000`
- Check platform-specific port requirements

**Database Persistence:**
- Add volume mounts for `/var/lib/grafana`
- Use managed database services for production

**Authentication:**
- Configure OAuth or LDAP for enterprise use
- Enable MFA for admin accounts

---

For specific platform issues, refer to their documentation or contact support.
