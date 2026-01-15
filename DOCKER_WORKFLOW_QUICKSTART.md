# 🐳 Docker Workflow - Quick Start

## What is it?

A GitHub Actions workflow that automatically builds, tests, and publishes your Docker images to Docker Hub with multi-architecture support.

## ⚡ Quick Setup (2 Minutes)

### Step 1: Add Secrets to GitHub

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add these two secrets:

```
Name: DOCKER_USERNAME
Value: your-dockerhub-username

Name: DOCKER_PASSWORD
Value: your-dockerhub-token-or-password
```

**💡 Tip:** Use a Docker Hub access token instead of your password:
- Go to https://hub.docker.com/settings/security
- Click **New Access Token**
- Copy and use it as `DOCKER_PASSWORD`

### Step 2: Push to GitHub

```bash
git add .
git commit -m "Add Docker workflow"
git push origin main
```

### Step 3: Watch it Work! 🎉

1. Go to **Actions** tab in GitHub
2. See **Docker Build and Push** workflow running
3. Wait ~5-10 minutes for first build
4. Check Docker Hub for your new image!

## 🎯 What Happens Automatically

When you push to `main` or `master`:

✅ Builds Docker image for AMD64 and ARM64  
✅ Runs security scan with Trivy  
✅ Tests container startup and health  
✅ Pushes to Docker Hub with multiple tags  
✅ Creates detailed summary in GitHub  

## 🏷️ Image Tags Created

Every push creates these tags:

```
owlbandocker/dashboard:latest           # Always latest
owlbandocker/dashboard:main-abc1234     # Branch + commit SHA
```

For version tags (e.g., `git tag v1.0.0`):

```
owlbandocker/dashboard:v1.0.0           # Full version
owlbandocker/dashboard:v1.0             # Major.minor
owlbandocker/dashboard:v1               # Major only
owlbandocker/dashboard:latest           # Latest tag
```

## 🚀 Using Your Image

### Pull and Run

```bash
# Pull the latest image
docker pull owlbandocker/dashboard:latest

# Run it
docker run -d -p 3000:3000 owlbandocker/dashboard:latest

# Access at http://localhost:3000
```

### In Docker Compose

```yaml
services:
  grafana:
    image: owlbandocker/dashboard:latest
    ports:
      - "3000:3000"
```

### In Kubernetes

```yaml
spec:
  containers:
  - name: grafana
    image: owlbandocker/dashboard:latest
    ports:
    - containerPort: 3000
```

## 🔍 Monitoring

### Check Workflow Status

1. Go to **Actions** tab
2. Click **Docker Build and Push**
3. View recent runs

### View Security Scans

1. Go to **Security** tab
2. Click **Code scanning alerts**
3. Filter by "Trivy"

### Check Docker Hub

Visit: https://hub.docker.com/r/owlbandocker/dashboard

## 🐛 Common Issues

### "Docker Hub credentials not configured"

**Fix:** Add `DOCKER_USERNAME` and `DOCKER_PASSWORD` secrets in GitHub Settings

### "Build failed"

**Fix:** Test locally first:
```bash
docker build -t test .
docker run -d -p 3000:3000 test
```

### "Security scan found vulnerabilities"

**Fix:** Check Security tab for details. Update base image in Dockerfile:
```dockerfile
FROM grafana/grafana:10.2.0  # Use specific version
```

## 📊 Workflow Triggers

| Trigger | What Happens | Pushes to Docker Hub? |
|---------|--------------|----------------------|
| Push to main | Full build + test + push | ✅ Yes |
| Push to other branch | Full build + test + push | ✅ Yes |
| Pull request | Build + test only | ❌ No |
| Create tag (v1.0.0) | Build + test + push | ✅ Yes (with version tags) |
| Manual trigger | Full build + test + push | ✅ Yes |

## 🎨 Customization

### Change Image Name

Edit `.github/workflows/docker.yml`:

```yaml
env:
  DOCKER_IMAGE: your-username/your-image-name
```

### Add More Platforms

```yaml
env:
  PLATFORMS: linux/amd64,linux/arm64,linux/arm/v7
```

### Skip Security Scan

Comment out the `security-scan` job in the workflow file.

## 📚 Full Documentation

For complete details, see [DOCKER_WORKFLOW_GUIDE.md](DOCKER_WORKFLOW_GUIDE.md)

## ✅ Success Checklist

- [ ] Added `DOCKER_USERNAME` secret to GitHub
- [ ] Added `DOCKER_PASSWORD` secret to GitHub
- [ ] Pushed code to main branch
- [ ] Workflow ran successfully (check Actions tab)
- [ ] Image appears on Docker Hub
- [ ] Can pull and run image locally
- [ ] Security scan shows no critical issues

## 🎉 You're Done!

Your Docker images are now automatically built and published on every push!

**Next Steps:**
- Set up automatic deployments using the image
- Configure security scan notifications
- Add custom tests to the workflow
- Create release tags for versions

---

**Need Help?** Check [DOCKER_WORKFLOW_GUIDE.md](DOCKER_WORKFLOW_GUIDE.md) or open an issue.
