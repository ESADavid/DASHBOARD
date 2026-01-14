# 🏦 Banking Dashboard - Complete Deployment Guide

A Grafana-based banking dashboard for transaction monitoring, ledger management, payroll tracking, and asset visualization.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Local Development](#local-development)
- [Cloud Deployment](#cloud-deployment)
- [Configuration](#configuration)
- [Security](#security)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Quick Start

### Option 1: One-Click Deploy (Easiest)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### Option 2: PowerShell Script (Windows)

```powershell
# Deploy to Render.com
.\deploy.ps1 -Platform render

# Deploy to Fly.io
.\deploy.ps1 -Platform fly

# Deploy to Railway
.\deploy.ps1 -Platform railway

# Deploy to all platforms
.\deploy.ps1 -Platform all
```

### Option 3: Docker Compose (Local)

```bash
# Start the dashboard
docker-compose up -d

# Access at http://localhost:3000
# Username: admin
# Password: admin123
```

---

## 💻 Local Development

### Prerequisites

- Docker Desktop
- Git
- PowerShell (Windows) or Bash (Linux/Mac)

### Setup

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd DASHBOARD
   ```

2. **Start with Docker Compose:**
   ```bash
   docker-compose up -d
   ```

3. **Access Grafana:**
   - URL: http://localhost:3000
   - Username: `admin`
   - Password: `admin123`

4. **Stop the dashboard:**
   ```bash
   docker-compose down
   ```

---

## ☁️ Cloud Deployment

### 1. Render.com (Recommended)

**Why Render?**
- ✅ Free tier available
- ✅ Auto-deploys from Git
- ✅ Built-in SSL
- ✅ No credit card required

**Steps:**
1. Push code to GitHub
2. Go to [render.com](https://render.com)
3. Click "New +" → "Web Service"
4. Connect repository
5. Render auto-detects `render.yaml`
6. Click "Create Web Service"

**Live URL:** `https://grafana-banking-dashboard.onrender.com`

---

### 2. Fly.io

**Why Fly.io?**
- ✅ 3 free VMs
- ✅ Global edge network
- ✅ Fast deployments

**Steps:**
```bash
# Install Fly CLI
iwr https://fly.io/install.ps1 -useb | iex

# Login
flyctl auth login

# Deploy
flyctl launch --config fly.toml

# Set admin password
flyctl secrets set GF_SECURITY_ADMIN_PASSWORD=your_secure_password
```

**Live URL:** `https://grafana-banking-dashboard.fly.dev`

---

### 3. Railway.app

**Why Railway?**
- ✅ $5 free credit/month
- ✅ Simple CLI
- ✅ GitHub integration

**Steps:**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
railway up

# Get URL
railway domain
```

---

### 4. Heroku (Container)

**Prerequisites:**
- Verified Heroku account
- Heroku CLI installed ✅

**Steps:**
```bash
# Login
heroku login

# Create app
heroku create your-app-name --stack container

# Login to container registry
heroku container:login

# Build and push
heroku container:push web -a your-app-name

# Release
heroku container:release web -a your-app-name

# Set password
heroku config:set GF_SECURITY_ADMIN_PASSWORD=your_password -a your-app-name

# Open app
heroku open -a your-app-name
```

---

### 5. Google Cloud Run

**Steps:**
```bash
# Build and push to Docker Hub
docker build -t owlbandocker/dashboard:latest .
docker push owlbandocker/dashboard:latest

# Deploy to Cloud Run
gcloud run deploy grafana-banking-dashboard \
  --image owlbandocker/dashboard:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 3000 \
  --set-env-vars GF_SECURITY_ADMIN_PASSWORD=your_password
```

---

### 6. Kubernetes

**Using existing configs:**
```bash
# Apply configurations
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Check status
kubectl get deployments
kubectl get services

# Get external IP
kubectl get service grafana-dashboard
```

---

## ⚙️ Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `GF_SECURITY_ADMIN_USER` | Admin username | `admin` |
| `GF_SECURITY_ADMIN_PASSWORD` | Admin password | `admin123` |
| `GF_SERVER_ROOT_URL` | Public URL | Platform-specific |
| `GF_INSTALL_PLUGINS` | Comma-separated plugins | Empty |

### Setting Environment Variables

**Render.com:**
- Go to Environment tab in dashboard
- Add variables

**Fly.io:**
```bash
flyctl secrets set GF_SECURITY_ADMIN_PASSWORD=your_password
```

**Railway:**
```bash
railway variables set GF_SECURITY_ADMIN_PASSWORD=your_password
```

**Heroku:**
```bash
heroku config:set GF_SECURITY_ADMIN_PASSWORD=your_password -a app-name
```

---

## 🔐 Security

### 1. Change Default Password

**Immediately after deployment:**
1. Login with default credentials
2. Go to Profile → Change Password
3. Set a strong password

### 2. Enable HTTPS

All cloud platforms provide free SSL certificates:
- ✅ Render: Automatic
- ✅ Fly.io: Automatic
- ✅ Railway: Automatic
- ✅ Heroku: Automatic

### 3. Configure Authentication

**OAuth Integration:**
```bash
# Example: Google OAuth
GF_AUTH_GOOGLE_ENABLED=true
GF_AUTH_GOOGLE_CLIENT_ID=your_client_id
GF_AUTH_GOOGLE_CLIENT_SECRET=your_client_secret
```

### 4. Database Security

For production, use managed databases:
- AWS RDS
- Google Cloud SQL
- Azure Database
- DigitalOcean Managed Databases

---

## 🔧 Troubleshooting

### Dashboard Not Loading

**Check:**
1. Container is running: `docker ps`
2. Port 3000 is exposed
3. Firewall rules allow traffic
4. Environment variables are set

**Logs:**
```bash
# Docker
docker logs grafana-banking-dashboard

# Fly.io
flyctl logs

# Railway
railway logs

# Heroku
heroku logs --tail -a app-name
```

### Can't Login

**Reset Password:**

**Docker:**
```bash
docker exec -it grafana-banking-dashboard grafana-cli admin reset-admin-password newpassword
```

**Cloud Platforms:**
Set `GF_SECURITY_ADMIN_PASSWORD` environment variable

### Data Not Persisting

**Add Volume Mounts:**

**Docker Compose:**
Already configured in `docker-compose.yml`

**Kubernetes:**
Add PersistentVolumeClaim in `deployment.yaml`

---

## 📊 Dashboard Features

### Included Visualizations

- 💰 Transaction Monitoring
- 📒 Ledger Management
- 💵 Payroll Tracking
- 📈 Asset Visualization
- 🔔 Real-time Alerts

### Data Sources

Configure in Grafana UI:
1. Go to Configuration → Data Sources
2. Add your database connections
3. Test connection
4. Save

**Supported Databases:**
- PostgreSQL
- MySQL
- MongoDB
- InfluxDB
- Prometheus
- And many more...

---

## 🚀 CI/CD

### GitHub Actions

Automatic deployment configured in `.github/workflows/deploy-multi-platform.yml`

**Setup:**
1. Add secrets in GitHub repository settings:
   - `RENDER_API_KEY`
   - `FLY_API_TOKEN`
   - `RAILWAY_TOKEN`
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`

2. Push to main branch → Auto-deploy! 🎉

---

## 📞 Support

### Documentation
- [Grafana Docs](https://grafana.com/docs)
- [Docker Docs](https://docs.docker.com)
- [Kubernetes Docs](https://kubernetes.io/docs)

### Platform Support
- **Render:** https://render.com/docs
- **Fly.io:** https://fly.io/docs
- **Railway:** https://docs.railway.app
- **Heroku:** https://devcenter.heroku.com

---

## 📝 License

[Your License Here]

---

## 🤝 Contributing

Contributions welcome! Please read CONTRIBUTING.md first.

---

## 🎯 Roadmap

- [ ] Multi-tenant support
- [ ] Advanced analytics
- [ ] Mobile app
- [ ] API integration
- [ ] Custom plugins

---

**Made with ❤️ for Banking Operations**
