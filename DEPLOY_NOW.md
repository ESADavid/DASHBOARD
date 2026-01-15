# 🚀 Deploy to Production - Step-by-Step Guide

## Current Status
- ✅ Docker installed (version 28.4.0)
- ✅ Docker daemon running
- ✅ Local dashboard running on port 3000
- ⏳ Ready to deploy to production

---

## Deployment Options

### Option 1: Quick Deploy via GitHub Actions (Recommended)
**Time:** 5 minutes  
**Cost:** Free  
**Difficulty:** Easy

This will automatically build and deploy when you configure GitHub secrets.

### Option 2: Manual Docker Hub Deploy
**Time:** 10 minutes  
**Cost:** Free  
**Difficulty:** Easy

Build and push Docker image manually.

### Option 3: Full Multi-Platform Deploy
**Time:** 30 minutes  
**Cost:** Free (with free tiers)  
**Difficulty:** Medium

Deploy to Docker Hub + Render.com + other platforms.

---

## 🎯 OPTION 1: Quick Deploy via GitHub Actions (RECOMMENDED)

### Step 1: Set Up Docker Hub Account (2 minutes)

1. **Go to Docker Hub:**
   - Visit: https://hub.docker.com
   - Sign up or log in

2. **Create Access Token:**
   - Click your profile → Account Settings
   - Go to Security → New Access Token
   - Name: "GitHub Actions"
   - Permissions: Read, Write, Delete
   - Click "Generate"
   - **COPY THE TOKEN** (you won't see it again!)

### Step 2: Add GitHub Secrets (2 minutes)

1. **Go to your GitHub repository:**
   - Visit: https://github.com/ESADavid/DASHBOARD/settings/secrets/actions

2. **Add DOCKER_USERNAME:**
   - Click "New repository secret"
   - Name: `DOCKER_USERNAME`
   - Value: Your Docker Hub username
   - Click "Add secret"

3. **Add DOCKER_PASSWORD:**
   - Click "New repository secret"
   - Name: `DOCKER_PASSWORD`
   - Value: The access token you copied
   - Click "Add secret"

### Step 3: Trigger Deployment (1 minute)

Run this command to trigger the workflow:

```powershell
git commit --allow-empty -m "Deploy to production"
git push origin main
```

### Step 4: Monitor Deployment

1. **Watch GitHub Actions:**
   - Visit: https://github.com/ESADavid/DASHBOARD/actions
   - Click on the latest workflow run
   - Watch the deployment progress

2. **Expected Timeline:**
   - Build Docker image: ~2 minutes
   - Push to Docker Hub: ~1 minute
   - Total: ~3 minutes

3. **Success Indicators:**
   - ✅ All jobs show green checkmarks
   - ✅ Docker image appears on Docker Hub
   - ✅ Deployment summary shows success

### Step 5: Verify on Docker Hub

1. **Check your Docker Hub:**
   - Visit: https://hub.docker.com/u/YOUR_USERNAME
   - Look for `dashboard` repository
   - Verify the `latest` tag exists

---

## 🎯 OPTION 2: Manual Docker Hub Deploy

### Step 1: Login to Docker Hub

```powershell
docker login
```

Enter your Docker Hub username and password when prompted.

### Step 2: Build the Docker Image

```powershell
docker build -t YOUR_USERNAME/dashboard:latest .
```

Replace `YOUR_USERNAME` with your Docker Hub username.

### Step 3: Push to Docker Hub

```powershell
docker push YOUR_USERNAME/dashboard:latest
```

### Step 4: Verify

Visit https://hub.docker.com/u/YOUR_USERNAME to see your image.

---

## 🎯 OPTION 3: Full Multi-Platform Deploy

### Prerequisites:
- ✅ Docker Hub account and secrets configured (from Option 1)
- ⏳ Render.com account (free)
- ⏳ Optional: Fly.io, Railway, etc.

### Step 1: Deploy to Docker Hub
Follow Option 1 or Option 2 above.

### Step 2: Set Up Render.com (10 minutes)

1. **Create Render Account:**
   - Visit: https://render.com
   - Sign up with GitHub

2. **Create Web Service:**
   - Click "New +" → "Web Service"
   - Select "Deploy an existing image from a registry"
   - Image URL: `YOUR_USERNAME/dashboard:latest`
   - Name: `grafana-banking-dashboard`
   - Region: Choose closest to you
   - Instance Type: Free
   - Click "Create Web Service"

3. **Configure Environment Variables:**
   - Go to Environment tab
   - Add these variables:
     ```
     GF_SECURITY_ADMIN_USER=admin
     GF_SECURITY_ADMIN_PASSWORD=your_secure_password
     GF_SERVER_ROOT_URL=https://grafana-banking-dashboard.onrender.com
     ```

4. **Get API Credentials (for GitHub Actions):**
   - Go to Account Settings → API Keys
   - Create new API key
   - Copy the key
   - Get Service ID from URL: `https://dashboard.render.com/web/srv-XXXXX`

5. **Add to GitHub Secrets:**
   - `RENDER_API_KEY`: Your API key
   - `RENDER_SERVICE_ID`: Your service ID (srv-xxxxx)

### Step 3: Deploy to Additional Platforms (Optional)

Follow the guides in `PRODUCTION_DEPLOYMENT_SETUP.md` for:
- Fly.io
- Railway
- Heroku
- DigitalOcean
- Kubernetes

---

## 📊 Deployment Checklist

### Before Deployment:
- [ ] Docker Hub account created
- [ ] Docker Hub access token generated
- [ ] GitHub secrets configured
- [ ] Local dashboard tested (http://localhost:3000)

### During Deployment:
- [ ] Commit pushed to GitHub
- [ ] GitHub Actions workflow triggered
- [ ] Build completed successfully
- [ ] Image pushed to Docker Hub

### After Deployment:
- [ ] Docker image visible on Docker Hub
- [ ] Image can be pulled: `docker pull YOUR_USERNAME/dashboard:latest`
- [ ] (Optional) Render service deployed
- [ ] (Optional) Dashboard accessible via URL

---

## 🔍 Verification Steps

### 1. Verify Docker Hub Image

```powershell
# Pull your image
docker pull YOUR_USERNAME/dashboard:latest

# Run it locally to test
docker run -d -p 3002:3000 YOUR_USERNAME/dashboard:latest

# Access it
start http://localhost:3002
```

### 2. Verify Render Deployment (if configured)

```
Visit: https://grafana-banking-dashboard.onrender.com
Login: admin / your_password
```

### 3. Check GitHub Actions

```
Visit: https://github.com/ESADavid/DASHBOARD/actions
Verify: Latest run shows success
```

---

## 🆘 Troubleshooting

### Issue: Docker login fails
**Solution:**
```powershell
# Use access token instead of password
docker login -u YOUR_USERNAME
# When prompted for password, paste your access token
```

### Issue: Build fails
**Solution:**
```powershell
# Check Dockerfile syntax
docker build --no-cache -t test .

# Check for errors in output
```

### Issue: Push fails
**Solution:**
```powershell
# Ensure you're logged in
docker login

# Check image name format
docker images | findstr dashboard

# Retry push
docker push YOUR_USERNAME/dashboard:latest
```

### Issue: GitHub Actions fails
**Solution:**
1. Check secrets are configured correctly
2. Verify secret names match exactly (case-sensitive)
3. Check workflow logs for specific errors
4. Ensure Docker Hub credentials are valid

---

## 💡 Quick Commands Reference

```powershell
# Check Docker status
docker ps

# Login to Docker Hub
docker login

# Build image
docker build -t YOUR_USERNAME/dashboard:latest .

# Push image
docker push YOUR_USERNAME/dashboard:latest

# Test image locally
docker run -d -p 3002:3000 YOUR_USERNAME/dashboard:latest

# View logs
docker logs CONTAINER_ID

# Stop container
docker stop CONTAINER_ID

# Trigger GitHub Actions
git commit --allow-empty -m "Deploy to production"
git push origin main
```

---

## 📞 Next Steps After Deployment

### Immediate:
1. ✅ Verify deployment succeeded
2. ✅ Test dashboard functionality
3. ✅ Change default admin password
4. ✅ Configure data sources

### Short-term:
1. Set up monitoring
2. Configure alerts
3. Add custom dashboards
4. Document any customizations

### Long-term:
1. Plan for scaling
2. Set up backups
3. Implement CI/CD improvements
4. Monitor costs and usage

---

## 🎉 Success Criteria

Your deployment is successful when:

- ✅ Docker image exists on Docker Hub
- ✅ Image can be pulled and run
- ✅ Dashboard is accessible
- ✅ Login works with credentials
- ✅ All panels display correctly
- ✅ No errors in logs

---

## 📚 Additional Resources

- **Docker Hub:** https://hub.docker.com
- **Render Docs:** https://render.com/docs
- **GitHub Actions:** https://github.com/ESADavid/DASHBOARD/actions
- **Full Guide:** `PRODUCTION_DEPLOYMENT_SETUP.md`
- **Quick Start:** `PRODUCTION_QUICK_START.md`

---

**Ready to deploy? Choose your option above and follow the steps!** 🚀
