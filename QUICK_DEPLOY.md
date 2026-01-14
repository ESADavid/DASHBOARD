# 🚀 Quick Deploy Guide - Banking Dashboard

## Immediate Deployment Options (No Account Verification Required)

### Option 1: Render.com (RECOMMENDED - Easiest)

1. **Go to:** https://render.com
2. **Sign up** with GitHub
3. **Click:** "New +" → "Web Service"
4. **Connect** this repository
5. **Render will auto-detect** the `render.yaml` file
6. **Click:** "Create Web Service"
7. **Done!** Your dashboard will be live at: `https://grafana-banking-dashboard.onrender.com`

**Default Credentials:**
- Username: `admin`
- Password: (auto-generated, check Render dashboard)

---

### Option 2: Fly.io (Fast & Free)

```bash
# Install Fly CLI (Windows PowerShell)
iwr https://fly.io/install.ps1 -useb | iex

# Login
flyctl auth login

# Deploy (from project directory)
flyctl launch --config fly.toml

# Your app will be live at: https://grafana-banking-dashboard.fly.dev
```

---

### Option 3: Railway.app (Simple)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Link to project
railway link

# Deploy
railway up

# Get URL
railway domain
```

---

### Option 4: Docker Hub + Cloud Run (Google Cloud)

```bash
# Build and push to Docker Hub
docker build -t owlbandocker/dashboard:latest .
docker push owlbandocker/dashboard:latest

# Deploy to Google Cloud Run
gcloud run deploy grafana-banking-dashboard \
  --image owlbandocker/dashboard:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 3000
```

---

### Option 5: DigitalOcean App Platform

1. **Go to:** https://cloud.digitalocean.com/apps
2. **Click:** "Create App"
3. **Connect** GitHub repository
4. **Select:** Dockerfile
5. **Configure:**
   - Port: 3000
   - Environment: Docker
6. **Deploy**

---

## 🔐 Security Setup (After Deployment)

### Set Admin Password:

**Render.com:**
- Go to Environment tab
- Add: `GF_SECURITY_ADMIN_PASSWORD` = your_secure_password

**Fly.io:**
```bash
flyctl secrets set GF_SECURITY_ADMIN_PASSWORD=your_secure_password
```

**Railway:**
```bash
railway variables set GF_SECURITY_ADMIN_PASSWORD=your_secure_password
```

---

## 📊 Access Your Dashboard

After deployment, access Grafana at your platform URL:
- **Render:** `https://grafana-banking-dashboard.onrender.com`
- **Fly.io:** `https://grafana-banking-dashboard.fly.dev`
- **Railway:** `https://your-app.railway.app`

**Login with:**
- Username: `admin`
- Password: (the one you set)

---

## 🎯 Next Steps After Deployment

1. **Change Admin Password** (if auto-generated)
2. **Configure Data Sources** (connect to your banking databases)
3. **Import Dashboard** (your `dashboard.json` is already included)
4. **Set Up Alerts** (for critical banking metrics)
5. **Configure Users** (add team members)

---

## 🆘 Troubleshooting

### Dashboard Not Loading?
- Check if port 3000 is exposed
- Verify environment variables are set
- Check platform logs

### Can't Login?
- Reset password via platform environment variables
- Check `GF_SECURITY_ADMIN_PASSWORD` is set

### Data Not Showing?
- Configure data sources in Grafana UI
- Check database connection strings
- Verify firewall rules

---

## 💰 Cost Comparison

| Platform | Free Tier | Paid Plans Start At |
|----------|-----------|---------------------|
| Render.com | ✅ 750 hours/month | $7/month |
| Fly.io | ✅ 3 VMs free | $1.94/month |
| Railway | ✅ $5 credit/month | $5/month |
| Google Cloud Run | ✅ 2M requests/month | Pay per use |
| DigitalOcean | ❌ | $5/month |
| Heroku | ❌ (requires verification) | $5/month |

---

## 🔄 Continuous Deployment

The `.github/workflows/deploy-multi-platform.yml` file is configured for automatic deployments.

**To enable:**
1. Go to GitHub repository settings
2. Add secrets for each platform:
   - `RENDER_API_KEY`
   - `FLY_API_TOKEN`
   - `RAILWAY_TOKEN`
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`
3. Push to main branch → Auto-deploy! 🎉

---

## 📞 Support

For platform-specific issues:
- **Render:** https://render.com/docs
- **Fly.io:** https://fly.io/docs
- **Railway:** https://docs.railway.app
- **Grafana:** https://grafana.com/docs

---

**Ready to deploy? Pick a platform above and follow the steps!** 🚀
