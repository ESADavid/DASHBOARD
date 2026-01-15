# 🐳 Docker Workflow Guide

## Overview

The `docker.yml` workflow is a comprehensive CI/CD pipeline dedicated to building, testing, and publishing Docker images for the Banking Dashboard. This workflow provides enterprise-grade features including multi-architecture builds, security scanning, and automated testing.

## 🎯 Features

### 1. **Multi-Architecture Support**
- Builds for `linux/amd64` (x86_64)
- Builds for `linux/arm64` (ARM64/Apple Silicon)
- Uses Docker Buildx for cross-platform compilation

### 2. **Smart Tagging Strategy**
The workflow automatically generates multiple tags:
- `latest` - Always points to the latest main branch build
- `<branch>-<sha>` - Branch name with commit SHA
- `v1.2.3` - Semantic version tags (when pushing tags)
- `v1.2` - Major.minor version
- `v1` - Major version only
- `pr-123` - Pull request builds

### 3. **Security Features**
- **Trivy Vulnerability Scanning** - Scans for CVEs in the image
- **SARIF Upload** - Results uploaded to GitHub Security tab
- **Severity Filtering** - Focuses on CRITICAL and HIGH vulnerabilities
- **Automated Reporting** - Security summary in workflow output

### 4. **Quality Assurance**
- **Container Health Checks** - Verifies Grafana starts correctly
- **API Testing** - Tests Grafana health endpoint
- **Port Validation** - Ensures port 3000 is accessible
- **Automated Cleanup** - Removes test containers

### 5. **Intelligent Execution**
- **Secret Validation** - Checks if Docker Hub credentials exist
- **Conditional Push** - Only pushes on main/master branches
- **PR Builds** - Builds but doesn't push for pull requests
- **Manual Trigger** - Can be run manually via workflow_dispatch

## 🚀 Workflow Triggers

### Automatic Triggers

```yaml
# Push to main or master branch
git push origin main

# Create a version tag
git tag v1.0.0
git push origin v1.0.0

# Open a pull request
# (builds but doesn't push)
```

### Manual Trigger

1. Go to **Actions** tab in GitHub
2. Select **Docker Build and Push** workflow
3. Click **Run workflow**
4. Choose branch and click **Run workflow**

## 📊 Workflow Jobs

### Job 1: Configuration Check
**Purpose:** Validates Docker Hub credentials and determines execution strategy

**Outputs:**
- `has-docker-creds` - Whether credentials are configured
- `should-push` - Whether to push images (not PR + has creds)

**Duration:** ~10 seconds

### Job 2: Build and Push
**Purpose:** Builds multi-architecture Docker image and pushes to Docker Hub

**Steps:**
1. Checkout code
2. Set up QEMU (for ARM emulation)
3. Set up Docker Buildx
4. Extract metadata and generate tags
5. Login to Docker Hub (if pushing)
6. Build and push image
7. Generate build summary

**Duration:** ~5-10 minutes (depending on cache)

**Cache Strategy:**
- Uses registry cache from previous builds
- Inline cache for faster subsequent builds
- Significantly reduces build time after first run

### Job 3: Image Testing
**Purpose:** Validates the built image works correctly

**Tests Performed:**
1. Pull latest image from Docker Hub
2. Start container on port 3000
3. Wait for container to be ready
4. Check container is running
5. Verify Grafana health endpoint responds
6. Inspect container metadata
7. Cleanup test container

**Duration:** ~1-2 minutes

**Failure Conditions:**
- Container fails to start
- Health check timeout (60 seconds)
- API doesn't respond

### Job 4: Security Scan
**Purpose:** Scans image for known vulnerabilities

**Scanning Tools:**
- **Trivy** - Industry-standard vulnerability scanner
- Checks against CVE databases
- Scans OS packages and application dependencies

**Severity Levels:**
- CRITICAL - Must fix immediately
- HIGH - Should fix soon
- MEDIUM - Fix when possible
- LOW - Informational

**Results:**
- SARIF format uploaded to GitHub Security
- Table format in workflow logs
- Summary in workflow output

**Duration:** ~2-3 minutes

### Job 5: Workflow Summary
**Purpose:** Aggregates results from all jobs

**Provides:**
- Overall workflow status
- Individual job results
- Docker Hub link (if pushed)
- Pull/run commands
- Troubleshooting info

**Duration:** ~5 seconds

## 🔧 Configuration

### Required GitHub Secrets

Add these secrets in **Settings → Secrets and variables → Actions**:

```
DOCKER_USERNAME=your-dockerhub-username
DOCKER_PASSWORD=your-dockerhub-password-or-token
```

**Security Best Practice:** Use a Docker Hub access token instead of your password:
1. Go to Docker Hub → Account Settings → Security
2. Click **New Access Token**
3. Name it "GitHub Actions"
4. Copy the token
5. Use it as `DOCKER_PASSWORD`

### Environment Variables

Edit these in the workflow file if needed:

```yaml
env:
  DOCKER_IMAGE: owlbandocker/dashboard  # Your Docker Hub image
  PLATFORMS: linux/amd64,linux/arm64    # Target platforms
```

## 📈 Usage Examples

### Example 1: Regular Development Push

```bash
# Make changes to your code
git add .
git commit -m "feat: add new dashboard panel"
git push origin main
```

**Result:**
- ✅ Workflow triggers automatically
- ✅ Builds multi-arch image
- ✅ Pushes to Docker Hub with tags:
  - `owlbandocker/dashboard:latest`
  - `owlbandocker/dashboard:main-abc1234`
- ✅ Runs tests and security scan
- ✅ Updates GitHub Security tab

### Example 2: Release Version

```bash
# Create and push a version tag
git tag v1.2.3
git push origin v1.2.3
```

**Result:**
- ✅ Workflow triggers on tag
- ✅ Builds and pushes with tags:
  - `owlbandocker/dashboard:latest`
  - `owlbandocker/dashboard:v1.2.3`
  - `owlbandocker/dashboard:v1.2`
  - `owlbandocker/dashboard:v1`
  - `owlbandocker/dashboard:main-abc1234`

### Example 3: Pull Request

```bash
# Create a PR from feature branch
git checkout -b feature/new-panel
git add .
git commit -m "feat: add transaction panel"
git push origin feature/new-panel
# Open PR on GitHub
```

**Result:**
- ✅ Workflow triggers on PR
- ✅ Builds image (validates Dockerfile)
- ❌ Does NOT push to Docker Hub
- ✅ Shows build status in PR
- ✅ Tag: `owlbandocker/dashboard:pr-123`

## 🎨 Customization

### Change Target Platforms

```yaml
env:
  PLATFORMS: linux/amd64,linux/arm64,linux/arm/v7
```

### Add Additional Tests

Add steps to the `test-image` job:

```yaml
- name: Custom test
  run: |
    # Your custom tests here
    docker exec test-container grafana-cli plugins ls
```

### Modify Security Scan Severity

```yaml
- name: Run Trivy vulnerability scanner
  uses: aquasecurity/trivy-action@master
  with:
    severity: 'CRITICAL,HIGH,MEDIUM,LOW'  # Add/remove levels
```

### Add Image Labels

```yaml
labels: |
  org.opencontainers.image.title=Banking Dashboard
  org.opencontainers.image.description=Your description
  org.opencontainers.image.vendor=Your Company
  custom.label=custom-value
```

## 🐛 Troubleshooting

### Issue: "Docker Hub credentials not configured"

**Solution:**
1. Go to repository **Settings → Secrets and variables → Actions**
2. Add `DOCKER_USERNAME` and `DOCKER_PASSWORD`
3. Re-run the workflow

### Issue: "Build failed - platform not supported"

**Solution:**
- Check if your Dockerfile supports multi-arch builds
- Some base images don't support ARM64
- Remove unsupported platforms from `PLATFORMS` env var

### Issue: "Health check timeout"

**Solution:**
1. Check if Grafana takes longer to start
2. Increase sleep time in test job:
   ```yaml
   sleep 15  # Increase from 10
   ```
3. Increase health check retries:
   ```yaml
   for i in {1..60}; do  # Increase from 30
   ```

### Issue: "Security scan found vulnerabilities"

**Solution:**
1. Check GitHub Security tab for details
2. Update base image in Dockerfile:
   ```dockerfile
   FROM grafana/grafana:latest  # Use specific version
   FROM grafana/grafana:10.2.0  # Pin to secure version
   ```
3. Review and fix critical vulnerabilities first

### Issue: "Push failed - unauthorized"

**Solution:**
1. Verify Docker Hub credentials are correct
2. Check if token has write permissions
3. Ensure repository exists on Docker Hub
4. Try regenerating access token

## 📊 Monitoring

### View Workflow Status

1. Go to **Actions** tab
2. Click on **Docker Build and Push**
3. View recent runs and their status

### Check Build Logs

1. Click on a workflow run
2. Click on individual jobs to see logs
3. Expand steps to see detailed output

### View Security Results

1. Go to **Security** tab
2. Click **Code scanning alerts**
3. Filter by tool: "Trivy"
4. Review and dismiss/fix vulnerabilities

### Docker Hub Verification

1. Go to https://hub.docker.com/r/owlbandocker/dashboard
2. Check **Tags** tab for new images
3. Verify multi-arch support (amd64, arm64)
4. Check image size and layers

## 🔄 Integration with Other Workflows

### Trigger Deployments After Build

The `docker.yml` workflow can trigger other workflows:

```yaml
# In deploy-simple.yml or deploy-multi-platform.yml
on:
  workflow_run:
    workflows: ["Docker Build and Push"]
    types:
      - completed
    branches: [main, master]
```

### Use Built Image in Deployments

Reference the image in deployment workflows:

```yaml
- name: Deploy to Render
  run: |
    curl -X POST "https://api.render.com/v1/services/${{ secrets.RENDER_SERVICE_ID }}/deploys" \
      -H "Authorization: Bearer ${{ secrets.RENDER_API_KEY }}"
```

## 📚 Best Practices

### 1. **Use Semantic Versioning**
```bash
git tag v1.0.0  # Major release
git tag v1.1.0  # Minor update
git tag v1.1.1  # Patch fix
```

### 2. **Pin Base Image Versions**
```dockerfile
# Bad - unpredictable
FROM grafana/grafana:latest

# Good - reproducible
FROM grafana/grafana:10.2.0
```

### 3. **Review Security Scans**
- Check Security tab weekly
- Fix CRITICAL vulnerabilities immediately
- Plan fixes for HIGH vulnerabilities
- Document accepted risks

### 4. **Monitor Build Times**
- First build: ~10 minutes
- Cached builds: ~2-3 minutes
- If builds are slow, check cache usage

### 5. **Test Locally First**
```bash
# Build locally before pushing
docker build -t test-image .
docker run -d -p 3000:3000 test-image
curl http://localhost:3000/api/health
```

## 🎯 Success Metrics

### Healthy Workflow Indicators:
- ✅ Build time: 2-5 minutes (with cache)
- ✅ Test success rate: >95%
- ✅ Security scan: 0 CRITICAL, <5 HIGH
- ✅ Image size: <500MB
- ✅ Multi-arch support: amd64 + arm64

### Warning Signs:
- ⚠️ Build time: >10 minutes
- ⚠️ Test failures: >5%
- ⚠️ Security: >5 CRITICAL vulnerabilities
- ⚠️ Image size: >1GB
- ⚠️ Single architecture only

## 🆘 Support

### Documentation
- [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Trivy Scanner](https://aquasecurity.github.io/trivy/)
- [Docker Hub](https://docs.docker.com/docker-hub/)

### Common Commands

```bash
# Pull the latest image
docker pull owlbandocker/dashboard:latest

# Run the container
docker run -d -p 3000:3000 owlbandocker/dashboard:latest

# Check running containers
docker ps

# View logs
docker logs <container-id>

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>
```

## 📝 Changelog

### Version 1.0.0 (Current)
- ✅ Multi-architecture builds (amd64, arm64)
- ✅ Automated security scanning with Trivy
- ✅ Container health checks and testing
- ✅ Smart tagging strategy
- ✅ Comprehensive build summaries
- ✅ PR build validation
- ✅ Manual workflow dispatch
- ✅ Cache optimization

---

**Need Help?** Open an issue or check the [GitHub Actions documentation](https://docs.github.com/en/actions).
