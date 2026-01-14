# GitHub Actions CI/CD Setup Guide

## ⚠️ About the Warnings

You may see warnings in VSCode like "Context access might be invalid: DOCKER_USERNAME". These are **normal** and **expected**. They appear because:

1. GitHub Actions secrets are configured in your repository settings (not in the workflow files)
2. VSCode's YAML validator cannot verify secrets that don't exist locally
3. The workflows will work perfectly once secrets are added to GitHub

**These warnings do NOT prevent the workflows from running successfully.**

---

## 🔧 Setting Up GitHub Secrets

To enable automated deployments, add these secrets to your GitHub repository:

### Step 1: Go to Repository Settings
1. Navigate to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**

### Step 2: Add Required Secrets

#### For Docker Hub Deployment (Required for all platforms)
```
Name: DOCKER_USERNAME
Value: your-dockerhub-username

Name: DOCKER_PASSWORD
Value: your-dockerhub-password-or-token
```

#### For Render.com Deployment (Optional)
```
Name: RENDER_API_KEY
Value: your-render-api-key

Name: RENDER_SERVICE_ID
Value: your-render-service-id
```

**How to get Render credentials:**
1. Go to https://dashboard.render.com/
2. Click your profile → Account Settings → API Keys
3. Create a new API key
4. Service ID is in your service URL: `https://dashboard.render.com/web/srv-XXXXX`

#### For Fly.io Deployment (Optional)
```
Name: FLY_API_TOKEN
Value: your-fly-api-token
```

**How to get Fly.io token:**
```bash
flyctl auth token
```

#### For Railway Deployment (Optional)
```
Name: RAILWAY_TOKEN
Value: your-railway-token
```

**How to get Railway token:**
```bash
railway login
railway whoami
```

#### For Heroku Deployment (Optional)
```
Name: HEROKU_API_KEY
Value: your-heroku-api-key

Name: HEROKU_APP_NAME
Value: your-app-name

Name: HEROKU_EMAIL
Value: your-heroku-email
```

**How to get Heroku API key:**
```bash
heroku auth:token
```

---

## 📋 Available Workflows

### 1. deploy-simple.yml (Recommended)
**Purpose:** Simple, reliable deployment to Docker Hub, Render, and Fly.io

**Triggers:**
- Push to `main` or `master` branch
- Manual trigger via GitHub Actions UI

**What it does:**
1. Builds Docker image
2. Pushes to Docker Hub
3. Deploys to Render.com (if secrets configured)
4. Deploys to Fly.io (if secrets configured)

**Status:** ✅ Production-ready, no errors

### 2. deploy-multi-platform.yml
**Purpose:** Deploy to multiple platforms simultaneously

**Triggers:**
- Push to `main` or `master` branch
- Manual trigger via GitHub Actions UI

**What it does:**
1. Builds Docker image
2. Pushes to Docker Hub
3. Deploys to Render, Fly.io, Railway, Heroku, DigitalOcean, Kubernetes

**Status:** ✅ Fixed Railway deployment issue

---

## 🚀 How to Use

### Option 1: Automatic Deployment (Recommended)

1. **Configure secrets** (see above)
2. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Deploy banking dashboard"
   git push origin main
   ```
3. **Watch deployment:**
   - Go to GitHub → Actions tab
   - See real-time deployment progress
   - Get deployment URLs when complete

### Option 2: Manual Trigger

1. Go to GitHub → Actions tab
2. Select workflow (deploy-simple or deploy-multi-platform)
3. Click "Run workflow"
4. Select branch
5. Click "Run workflow" button

---

## 🔍 Monitoring Deployments

### View Workflow Runs
1. Go to your repository on GitHub
2. Click the **Actions** tab
3. Click on a workflow run to see details

### Check Deployment Status
Each workflow shows:
- ✅ Success: Green checkmark
- ❌ Failure: Red X
- 🟡 In Progress: Yellow circle
- ⚪ Skipped: Gray circle

### View Logs
1. Click on a workflow run
2. Click on a job (e.g., "Build and Push Docker Image")
3. Expand steps to see detailed logs

---

## 🐛 Troubleshooting

### Workflow Fails with "Secret not found"
**Solution:** Add the required secret to GitHub repository settings

### Docker Build Fails
**Solution:** 
1. Test locally: `docker build -t test .`
2. Check Dockerfile syntax
3. Ensure all required files exist

### Render Deployment Fails
**Solution:**
1. Verify RENDER_API_KEY is correct
2. Check RENDER_SERVICE_ID matches your service
3. Ensure render.yaml is in repository root

### Fly.io Deployment Fails
**Solution:**
1. Verify FLY_API_TOKEN is valid: `flyctl auth token`
2. Ensure fly.toml is configured correctly
3. Check if app exists: `flyctl apps list`

---

## 📊 Workflow Features

### Caching
- Docker layer caching for faster builds
- Reduces build time by 50-70%

### Multi-platform Support
- Builds for linux/amd64 architecture
- Compatible with all major cloud platforms

### Automatic Tagging
- `latest` tag for most recent build
- Git SHA tag for version tracking
- Example: `owlbandocker/dashboard:abc1234`

### Notifications
- Success/failure notifications in workflow summary
- Detailed logs for debugging

---

## 🔐 Security Best Practices

### Never Commit Secrets
❌ Don't do this:
```yaml
env:
  API_KEY: "my-secret-key-123"  # NEVER!
```

✅ Do this instead:
```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}  # Correct!
```

### Use Personal Access Tokens
- For Docker Hub, use access tokens instead of passwords
- For GitHub, use fine-grained personal access tokens
- Rotate tokens regularly

### Limit Secret Scope
- Only add secrets that are actually needed
- Use separate tokens for different environments
- Review and remove unused secrets

---

## 📈 Deployment Workflow Diagram

```
┌─────────────────┐
│  Push to GitHub │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Build Docker   │
│     Image       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Push to        │
│  Docker Hub     │
└────────┬────────┘
         │
         ├──────────────┬──────────────┐
         ▼              ▼              ▼
    ┌────────┐    ┌─────────┐    ┌────────┐
    │ Render │    │ Fly.io  │    │Railway │
    └────────┘    └─────────┘    └────────┘
         │              │              │
         └──────────────┴──────────────┘
                        │
                        ▼
                ┌───────────────┐
                │   Dashboard   │
                │     LIVE!     │
                └───────────────┘
```

---

## 🎯 Quick Reference

### Minimum Required Secrets
```
DOCKER_USERNAME
DOCKER_PASSWORD
```

### For Render Deployment
```
RENDER_API_KEY
RENDER_SERVICE_ID
```

### For Fly.io Deployment
```
FLY_API_TOKEN
```

### Workflow Files
- `deploy-simple.yml` - Simple, reliable (recommended)
- `deploy-multi-platform.yml` - Advanced, multi-platform

### Commands
```bash
# View workflow status
gh workflow list

# Run workflow manually
gh workflow run deploy-simple.yml

# View workflow runs
gh run list

# View specific run
gh run view <run-id>
```

---

## ✅ Checklist Before First Deployment

- [ ] Repository pushed to GitHub
- [ ] Docker Hub account created
- [ ] DOCKER_USERNAME secret added
- [ ] DOCKER_PASSWORD secret added
- [ ] Target platform account created (Render/Fly.io/etc)
- [ ] Platform-specific secrets added
- [ ] Workflow file exists in `.github/workflows/`
- [ ] All required files in repository (Dockerfile, render.yaml, etc)
- [ ] Tested Docker build locally
- [ ] Ready to push and deploy!

---

## 🎉 Success!

Once configured, every push to `main` will:
1. ✅ Build your Docker image
2. ✅ Push to Docker Hub
3. ✅ Deploy to configured platforms
4. ✅ Make your dashboard live!

**No manual deployment needed - it's all automatic!** 🚀

---

## 📞 Need Help?

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Docker Hub:** https://hub.docker.com
- **Render Docs:** https://render.com/docs
- **Fly.io Docs:** https://fly.io/docs
- **Railway Docs:** https://docs.railway.app

---

**Last Updated:** January 14, 2026
**Status:** Production Ready ✅
