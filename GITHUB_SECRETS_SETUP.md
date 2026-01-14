# 🔐 GitHub Secrets Setup Guide

This guide explains how to configure GitHub repository secrets for the multi-platform deployment workflow.

## 📋 Table of Contents

- [Overview](#overview)
- [How to Add Secrets](#how-to-add-secrets)
- [Required Secrets by Platform](#required-secrets-by-platform)
- [Testing Without All Secrets](#testing-without-all-secrets)
- [Security Best Practices](#security-best-practices)

---

## Overview

The GitHub Actions workflow (`deploy-multi-platform.yml`) supports deployment to multiple platforms. Each platform requires specific secrets to be configured. **You don't need to configure all platforms** - the workflow will automatically skip platforms where secrets are not configured.

### Workflow Behavior:
- ✅ **Validates secrets** before running deployments
- ✅ **Skips platforms** where secrets are missing
- ✅ **Continues on errors** - one platform failure won't stop others
- ✅ **Shows summary** of all deployment results

---

## How to Add Secrets

### Step-by-Step:

1. **Navigate to your GitHub repository**
2. Click **Settings** (top menu)
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Enter the **Name** (exactly as shown below)
6. Enter the **Value** (your credential/token)
7. Click **Add secret**

### Screenshot Guide:
```
Repository → Settings → Secrets and variables → Actions → New repository secret
```

---

## Required Secrets by Platform

### 🐳 Docker Hub (Required for all deployments)

The Docker Hub deployment is the foundation - all other platforms pull from this image.

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `DOCKER_USERNAME` | Your Docker Hub username | Your Docker Hub account username |
| `DOCKER_PASSWORD` | Docker Hub access token | Docker Hub → Account Settings → Security → New Access Token |

**Setup Instructions:**
1. Go to https://hub.docker.com
2. Sign in or create account
3. Click your profile → **Account Settings**
4. Go to **Security** → **New Access Token**
5. Name: "GitHub Actions"
6. Permissions: Read, Write, Delete
7. Copy the token (you won't see it again!)
8. Add to GitHub secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: The access token you just created

---

### 🎨 Render.com (Recommended - Free & Easy)

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `RENDER_API_KEY` | Render API key | Render Dashboard → Account Settings → API Keys |
| `RENDER_SERVICE_ID` | Service ID | Create service first, then copy ID from URL |

**Setup Instructions:**
1. Go to https://render.com and sign up
2. Create a new **Web Service**:
   - Connect your GitHub repository
   - Choose "Docker" as environment
   - Set Docker image: `owlbandocker/dashboard:latest`
   - Click "Create Web Service"
3. Get your **API Key**:
   - Dashboard → Account Settings → API Keys
   - Click "Create API Key"
   - Copy the key
4. Get your **Service ID**:
   - Go to your service dashboard
   - Copy the ID from the URL: `https://dashboard.render.com/web/srv-XXXXX`
   - The `srv-XXXXX` part is your Service ID
5. Add to GitHub secrets:
   - `RENDER_API_KEY`: Your API key
   - `RENDER_SERVICE_ID`: Your service ID (e.g., `srv-xxxxx`)

---

### ✈️ Fly.io (Fast & Free)

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `FLY_API_TOKEN` | Fly.io API token | `flyctl auth token` command |

**Setup Instructions:**
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
3. Get your API token:
   ```bash
   flyctl auth token
   ```
4. Copy the token
5. Add to GitHub secrets:
   - `FLY_API_TOKEN`: The token from the command

---

### 🚂 Railway.app (Simple Deployment)

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `RAILWAY_TOKEN` | Railway API token | Railway Dashboard → Account → Tokens |

**Setup Instructions:**
1. Go to https://railway.app and sign up
2. Go to **Account Settings** → **Tokens**
3. Click **Create Token**
4. Name it "GitHub Actions"
5. Copy the token
6. Add to GitHub secrets:
   - `RAILWAY_TOKEN`: Your Railway token

---

### 🟣 Heroku (Classic Platform)

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `HEROKU_API_KEY` | Heroku API key | Heroku Dashboard → Account Settings → API Key |
| `HEROKU_APP_NAME` | Your Heroku app name | The name you choose for your app |
| `HEROKU_EMAIL` | Your Heroku email | Your Heroku account email |

**Setup Instructions:**
1. Go to https://heroku.com and sign up
2. Create a new app:
   ```bash
   heroku create your-app-name --stack container
   ```
3. Get your API key:
   - Dashboard → Account Settings → API Key
   - Click "Reveal" and copy
4. Add to GitHub secrets:
   - `HEROKU_API_KEY`: Your API key
   - `HEROKU_APP_NAME`: Your app name (e.g., `grafana-dashboard`)
   - `HEROKU_EMAIL`: Your Heroku account email

---

### 🌊 DigitalOcean App Platform

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `DIGITALOCEAN_ACCESS_TOKEN` | DO API token | DigitalOcean → API → Generate New Token |
| `DO_APP_ID` | App ID | Create app first, then get ID from URL |

**Setup Instructions:**
1. Go to https://cloud.digitalocean.com
2. Create API token:
   - Click **API** in left sidebar
   - Click **Generate New Token**
   - Name: "GitHub Actions"
   - Scopes: Read & Write
   - Copy the token
3. Create an app:
   - Go to **Apps** → **Create App**
   - Connect GitHub repository
   - Choose Docker deployment
   - Note the App ID from URL
4. Add to GitHub secrets:
   - `DIGITALOCEAN_ACCESS_TOKEN`: Your API token
   - `DO_APP_ID`: Your app ID

---

### ☸️ Kubernetes (Advanced)

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `KUBE_CONFIG` | Base64 encoded kubeconfig | `cat ~/.kube/config \| base64` |

**Setup Instructions:**
1. Ensure you have a Kubernetes cluster running
2. Get your kubeconfig:
   ```bash
   # Linux/Mac
   cat ~/.kube/config | base64 -w 0
   
   # Windows PowerShell
   [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-Content ~/.kube/config -Raw)))
   ```
3. Copy the base64 encoded string
4. Add to GitHub secrets:
   - `KUBE_CONFIG`: The base64 encoded kubeconfig

---

## Testing Without All Secrets

**Good News:** You don't need to configure all platforms to test the workflow!

### Minimal Setup (Recommended for Testing):

**Option 1: Docker Hub Only**
- Configure only `DOCKER_USERNAME` and `DOCKER_PASSWORD`
- Workflow will build and push Docker image
- All other deployments will be skipped gracefully
- Perfect for testing the workflow logic

**Option 2: Docker Hub + One Platform**
- Configure Docker Hub secrets
- Add secrets for one platform (e.g., Render)
- Test end-to-end deployment to that platform

### What Happens When Secrets Are Missing:

```yaml
# Example workflow output:
🔍 Checking configured deployment targets...
Docker Hub: true ✅
Render: false ⏭️ (skipped)
Fly.io: false ⏭️ (skipped)
Railway: false ⏭️ (skipped)
Heroku: false ⏭️ (skipped)
DigitalOcean: false ⏭️ (skipped)
Kubernetes: false ⏭️ (skipped)
```

The workflow will:
- ✅ Build and push Docker image
- ⏭️ Skip all platforms without secrets
- ✅ Show deployment summary
- ✅ Complete successfully

---

## Security Best Practices

### ✅ DO:
- ✅ Use API tokens instead of passwords when possible
- ✅ Create tokens with minimal required permissions
- ✅ Name tokens clearly (e.g., "GitHub Actions")
- ✅ Rotate tokens periodically (every 90 days)
- ✅ Delete tokens when no longer needed
- ✅ Use separate tokens for different purposes

### ❌ DON'T:
- ❌ Share tokens in chat, email, or code
- ❌ Commit tokens to Git (even in private repos)
- ❌ Use personal passwords as secrets
- ❌ Give tokens more permissions than needed
- ❌ Reuse tokens across multiple services

### 🔒 Token Security Checklist:

- [ ] All tokens are stored only in GitHub Secrets
- [ ] Tokens have descriptive names
- [ ] Tokens have minimal required permissions
- [ ] You have a list of all active tokens
- [ ] You know how to revoke each token if needed
- [ ] Tokens are not shared with anyone
- [ ] Old/unused tokens are deleted

---

## Verification Steps

After adding secrets, verify they're configured correctly:

### 1. Check Secrets Are Added:
- Go to: Repository → Settings → Secrets and variables → Actions
- You should see your secrets listed (values are hidden)

### 2. Test the Workflow:
```bash
# Make a small change and push
git add .
git commit -m "Test workflow with secrets"
git push origin main
```

### 3. Monitor the Workflow:
- Go to: Repository → Actions
- Click on the latest workflow run
- Check the "check-secrets" job output
- Verify which platforms are configured

### 4. Review Deployment Summary:
- Scroll to the bottom of the workflow run
- Check the "deployment-summary" job
- Review which deployments succeeded/failed

---

## Troubleshooting

### Secret Not Working?

**Check:**
1. Secret name is **exactly** as specified (case-sensitive)
2. No extra spaces in secret value
3. Token hasn't expired
4. Token has correct permissions
5. Service/app exists and is accessible

### Workflow Still Failing?

**Debug Steps:**
1. Check workflow logs for specific error messages
2. Verify secret values are correct (regenerate if unsure)
3. Test credentials manually with CLI tools
4. Check platform status pages for outages
5. Review platform-specific documentation

### Common Issues:

| Issue | Solution |
|-------|----------|
| "Secret not found" | Check secret name spelling (case-sensitive) |
| "Authentication failed" | Regenerate token and update secret |
| "Permission denied" | Ensure token has write permissions |
| "Service not found" | Verify service/app ID is correct |
| "Rate limit exceeded" | Wait and retry, or upgrade plan |

---

## Quick Reference

### Minimum Secrets for Testing:
```
DOCKER_USERNAME=your-username
DOCKER_PASSWORD=your-token
```

### Recommended Secrets for Production:
```
# Docker Hub (Required)
DOCKER_USERNAME=your-username
DOCKER_PASSWORD=your-token

# Render (Recommended)
RENDER_API_KEY=your-api-key
RENDER_SERVICE_ID=srv-xxxxx

# Optional: Add more platforms as needed
FLY_API_TOKEN=your-token
RAILWAY_TOKEN=your-token
```

---

## Next Steps

1. ✅ Choose which platforms you want to deploy to
2. ✅ Follow the setup instructions for each platform
3. ✅ Add secrets to GitHub repository
4. ✅ Push a commit to trigger the workflow
5. ✅ Monitor the deployment in GitHub Actions
6. ✅ Access your deployed dashboard!

---

## Support

### Platform Documentation:
- **Docker Hub:** https://docs.docker.com/docker-hub/
- **Render:** https://render.com/docs
- **Fly.io:** https://fly.io/docs
- **Railway:** https://docs.railway.app
- **Heroku:** https://devcenter.heroku.com
- **DigitalOcean:** https://docs.digitalocean.com/products/app-platform/

### GitHub Actions:
- **Secrets:** https://docs.github.com/en/actions/security-guides/encrypted-secrets
- **Workflows:** https://docs.github.com/en/actions/using-workflows

---

**Last Updated:** January 2025  
**Status:** Ready for Use 🚀
