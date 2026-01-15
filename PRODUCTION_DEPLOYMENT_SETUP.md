# 🚀 Production Deployment Environment Setup

## Overview

This guide will help you set up a complete production deployment environment for the Banking Dashboard across multiple platforms.

---

## 📋 Prerequisites Checklist

Before starting, ensure you have:

- [ ] GitHub account with repository access
- [ ] Docker Hub account (free tier available)
- [ ] At least ONE cloud platform account (recommended: Render.com - free tier)
- [ ] Git installed and configured
- [ ] Docker Desktop installed (for local testing)
- [ ] Terminal/PowerShell access

---

## 🎯 Deployment Strategy

### Recommended Approach (Easiest):

**Phase 1: Docker Hub (Required)**
- Build and push Docker image
- This is the foundation for all other deployments

**Phase 2: Render.com (Recommended)**
- Free tier available
- Easy setup
- Automatic deployments from Docker Hub

**Phase 3: Additional Platforms (Optional)**
- Fly.io, Railway, Heroku, etc.
- Add as needed for redundancy

---

## 🐳 Phase 1: Docker Hub Setup (REQUIRED)

### Step 1: Create Docker Hub Account

1. Go to https://hub.docker.com
2. Click "Sign Up"
3. Create account (free tier is sufficient)
4. Verify your email

### Step 2: Create Access Token

1. Log in to Docker Hub
2. Click your profile → **Account Settings**
3. Go to **Security** → **New Access Token**
4. Token details:
   - **Description:** "GitHub Actions Deployment"
   - **Access permissions:** Read, Write, Delete
5. Click **Generate**
6. **IMPORTANT:** Copy the token immediately (you won't see it again!)

### Step 3: Configure GitHub Secrets

1. Go to your GitHub repository: https://github.com/ESADavid/DASHBOARD
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**

**Add these two secrets:**

**Secret 1:**
- Name: `DOCKER_USERNAME`
- Value: Your Docker Hub username

**Secret 2:**
- Name: `DOCKER_PASSWORD`
- Value: The access token you just created

### Step 4: Verify Docker Hub Setup

After adding secrets, push a commit to trigger the workflow:

```bash
# Make a small change
echo "# Production Ready" >> README.md
git add README.md
git commit -m "Trigger Docker Hub deployment"
git push origin main
```

Check GitHub Actions to verify the Docker image builds and pushes successfully.

---

## 🎨 Phase 2: Render.com Setup (RECOMMENDED)

### Why Render?
- ✅ Free tier available
- ✅ Easy setup (5 minutes)
- ✅ Automatic deployments
- ✅ Free SSL certificates
- ✅ Custom domains supported

### Step 1: Create Render Account

1. Go to https://render.com
2. Click "Get Started"
3. Sign up with GitHub (recommended) or email
4. Verify your email

### Step 2: Create Web Service

1. Click **New** → **Web Service**
2. Choose **Deploy an existing image from a registry**
3. Image URL: `docker.io/owlbandocker/dashboard:latest`
4. Service details:
   - **Name:** `grafana-banking-dashboard`
   - **Region:** Choose closest to your users
   - **Instance Type:** Free (sufficient for testing)
5. Click **Create Web Service**

### Step 3: Configure Environment Variables

In your Render service dashboard:

1. Go to **Environment** tab
2. Add these variables:

```
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=your-secure-password-here
GF_SERVER_ROOT_URL=https://grafana-banking-dashboard.onrender.com
GF_INSTALL_PLUGINS=
```

**IMPORTANT:** Replace `your-secure-password-here` with a strong password!

### Step 4: Get Render API Credentials

1. Go to **Account Settings** → **API Keys**
2. Click **Create API Key**
3. Name: "GitHub Actions"
4. Copy the API key

### Step 5: Get Service ID

1. Go to your service dashboard
2. Look at the URL: `https://dashboard.render.com/web/srv-XXXXX`
3. The `srv-XXXXX` part is your Service ID

### Step 6: Add Render Secrets to GitHub

Go to GitHub repository → Settings → Secrets and variables → Actions

**Add these secrets:**

**Secret 1:**
- Name: `RENDER_API_KEY`
- Value: Your Render API key

**Secret 2:**
- Name: `RENDER_SERVICE_ID`
- Value: Your service ID (e.g., `srv-xxxxx`)

### Step 7: Verify Render Deployment

Push a commit to trigger deployment:

```bash
git commit --allow-empty -m "Trigger Render deployment"
git push origin main
```

Your dashboard will be available at:
`https://grafana-banking-dashboard.onrender.com`

---

## ✈️ Phase 3: Additional Platforms (OPTIONAL)

### Option A: Fly.io

**Pros:** Fast, global edge network, free tier
**Setup Time:** 10 minutes

1. Install Fly CLI:
   ```powershell
   iwr https://fly.io/install.ps1 -useb | iex
   ```

2. Sign up and login:
   ```bash
   flyctl auth signup
   # or
   flyctl auth login
   ```

3. Get API token:
   ```bash
   flyctl auth token
   ```

4. Add to GitHub secrets:
   - Name: `FLY_API_TOKEN`
   - Value: Your token

### Option B: Railway.app

**Pros:** Simple, automatic deployments, free tier
**Setup Time:** 5 minutes

1. Go to https://railway.app
2. Sign up with GitHub
3. Go to **Account Settings** → **Tokens**
4. Create new token: "GitHub Actions"
5. Add to GitHub secrets:
   - Name: `RAILWAY_TOKEN`
   - Value: Your token

### Option C: Heroku

**Pros:** Mature platform, extensive documentation
**Cons:** Requires payment method verification

1. Go to https://heroku.com
2. Sign up and verify payment method
3. Get API key from Account Settings
4. Create app:
   ```bash
   heroku create grafana-banking-dashboard --stack container
   ```
5. Add to GitHub secrets:
   - Name: `HEROKU_API_KEY`
   - Value: Your API key
   - Name: `HEROKU_APP_NAME`
   - Value: `grafana-banking-dashboard`
   - Name: `HEROKU_EMAIL`
   - Value: Your Heroku email

---

## 🔒 Security Best Practices

### 1. Strong Passwords

Generate secure passwords:
```powershell
# PowerShell
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_})
```

### 2. Environment Variables

Never commit these to Git:
- Passwords
- API keys
- Tokens
- Database credentials

### 3. Secret Rotation

Rotate secrets every 90 days:
- [ ] Docker Hub tokens
- [ ] Platform API keys
- [ ] Admin passwords

### 4. Access Control

- Use separate tokens for different purposes
- Limit token permissions to minimum required
- Revoke unused tokens immediately

---

## 📊 Monitoring & Maintenance

### Health Checks

Monitor these endpoints:
- Render: `https://grafana-banking-dashboard.onrender.com/api/health`
- Fly.io: `https://grafana-banking-dashboard.fly.dev/api/health`

### Logs

Access logs:
- **Render:** Dashboard → Logs tab
- **Fly.io:** `flyctl logs`
- **Railway:** Dashboard → Deployments → Logs

### Uptime Monitoring

Set up monitoring with:
- UptimeRobot (free)
- Pingdom
- StatusCake

---

## 🧪 Testing Production Deployment

### 1. Verify Deployment

```bash
# Check if service is running
curl -I https://your-deployment-url.com

# Expected: HTTP 200 OK
```

### 2. Test Login

1. Navigate to your deployment URL
2. Login with:
   - Username: `admin`
   - Password: Your configured password
3. Verify dashboard loads correctly

### 3. Check Functionality

- [ ] Dashboard displays correctly
- [ ] All panels render
- [ ] No console errors
- [ ] Responsive design works
- [ ] Data sources connect (if configured)

---

## 🚨 Troubleshooting

### Issue: Docker build fails

**Solution:**
```bash
# Test build locally
docker build -t test-dashboard .
docker run -p 3000:3000 test-dashboard
```

### Issue: Deployment fails

**Check:**
1. GitHub secrets are configured correctly
2. Service/app exists on platform
3. API tokens haven't expired
4. Platform status (check status pages)

### Issue: Can't access deployment

**Check:**
1. Service is running (check platform dashboard)
2. URL is correct
3. Firewall/network settings
4. SSL certificate is valid

### Issue: Login fails

**Check:**
1. Environment variables are set correctly
2. Password is correct
3. No special characters causing issues
4. Check service logs for errors

---

## 📈 Scaling Considerations

### When to Scale:

- Response time > 2 seconds
- CPU usage > 80%
- Memory usage > 80%
- Error rate > 1%

### How to Scale:

**Render:**
- Upgrade to paid tier
- Increase instance size
- Add more instances

**Fly.io:**
```bash
flyctl scale count 2
flyctl scale vm shared-cpu-2x
```

**Railway:**
- Upgrade plan in dashboard
- Adjust resources

---

## 💰 Cost Estimation

### Free Tier Limits:

| Platform | Free Tier | Limits |
|----------|-----------|--------|
| Docker Hub | Yes | Unlimited public images |
| Render | Yes | 750 hours/month, sleeps after 15min |
| Fly.io | Yes | 3 shared VMs, 160GB bandwidth |
| Railway | Yes | $5 credit/month |
| Heroku | No | Requires payment method |

### Recommended for Production:

**Small Scale (< 1000 users):**
- Render: $7/month (starter)
- Total: ~$7/month

**Medium Scale (< 10000 users):**
- Render: $25/month (standard)
- Total: ~$25/month

---

## ✅ Production Readiness Checklist

### Before Going Live:

- [ ] Docker Hub secrets configured
- [ ] At least one platform deployed
- [ ] Strong admin password set
- [ ] SSL certificate active
- [ ] Health checks passing
- [ ] Monitoring configured
- [ ] Backup strategy defined
- [ ] Documentation updated
- [ ] Team trained on access
- [ ] Incident response plan ready

### Post-Deployment:

- [ ] Verify all functionality
- [ ] Test from different locations
- [ ] Check mobile responsiveness
- [ ] Monitor for 24 hours
- [ ] Document any issues
- [ ] Update runbooks
- [ ] Notify stakeholders

---

## 📞 Support Resources

### Platform Documentation:
- **Docker Hub:** https://docs.docker.com/docker-hub/
- **Render:** https://render.com/docs
- **Fly.io:** https://fly.io/docs
- **Railway:** https://docs.railway.app

### Community Support:
- **Grafana Community:** https://community.grafana.com
- **Docker Community:** https://forums.docker.com
- **Stack Overflow:** Tag questions appropriately

---

## 🎯 Quick Start Summary

**Minimum for Production (30 minutes):**

1. ✅ Create Docker Hub account
2. ✅ Generate Docker Hub token
3. ✅ Add Docker secrets to GitHub
4. ✅ Create Render account
5. ✅ Deploy to Render
6. ✅ Configure environment variables
7. ✅ Add Render secrets to GitHub
8. ✅ Push commit to trigger deployment
9. ✅ Verify deployment works
10. ✅ Test login and functionality

**Your dashboard will be live at:**
`https://grafana-banking-dashboard.onrender.com`

---

**Last Updated:** January 2025
**Status:** Ready for Production Setup 🚀
