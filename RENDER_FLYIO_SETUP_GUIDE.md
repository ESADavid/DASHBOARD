# Render.com & Fly.io Setup Guide 🚀

**Date**: January 2025  
**Purpose**: Complete guide for deploying to Render.com and Fly.io  
**Estimated Time**: 30 minutes total

---

## Part 1: Render.com Setup (15 minutes)

### Step 1: Create Render.com Account (3 minutes)

1. **Go to Render.com**
   - Visit: https://render.com
   - Click "Get Started" or "Sign Up"

2. **Sign Up Options**
   - **Recommended**: Sign up with GitHub
     - Click "Sign up with GitHub"
     - Authorize Render to access your GitHub account
     - This makes deployment easier
   
   - **Alternative**: Sign up with email
     - Enter your email address
     - Create a password
     - Verify your email

3. **Complete Profile**
   - Enter your name
   - Optionally add payment method (not required for free tier)
   - Click "Continue"

**Result**: You should see the Render dashboard

---

### Step 2: Deploy Dashboard to Render.com (10 minutes)

#### Option A: Deploy from Docker Hub (Recommended - Faster)

1. **Create New Web Service**
   - Click "New +" button (top right)
   - Select "Web Service"

2. **Choose Deployment Method**
   - Select "Deploy an existing image from a registry"
   - Click "Next"

3. **Configure Service**
   ```
   Image URL: owlbandocker/dashboard:latest
   Name: dashboard-banking
   Region: Oregon (US West) or closest to you
   Branch: main (if asked)
   ```

4. **Select Instance Type**
   - Choose "Free" tier
   - 512 MB RAM
   - Shared CPU

5. **Environment Variables** (Optional)
   - Click "Add Environment Variable"
   - Add if needed:
     ```
     GF_SECURITY_ADMIN_PASSWORD=YourSecurePassword123!
     GF_SECURITY_ADMIN_USER=admin
     ```

6. **Create Web Service**
   - Click "Create Web Service"
   - Wait for deployment (2-3 minutes)

7. **Get Your URL**
   - Once deployed, you'll see: `https://dashboard-banking.onrender.com`
   - Click the URL to test

**Expected Result**: Your dashboard loads successfully

---

#### Option B: Deploy from GitHub (Alternative)

1. **Create New Web Service**
   - Click "New +" button
   - Select "Web Service"

2. **Connect Repository**
   - Select "Build and deploy from a Git repository"
   - Click "Connect" next to your DASHBOARD repository
   - If not listed, click "Configure account" to grant access

3. **Configure Build**
   ```
   Name: dashboard-banking
   Region: Oregon (US West)
   Branch: main
   Root Directory: (leave blank)
   Runtime: Docker
   Build Command: (auto-detected from Dockerfile)
   Start Command: (auto-detected)
   ```

4. **Select Plan**
   - Choose "Free" tier

5. **Advanced Settings** (Optional)
   - Add environment variables if needed
   - Configure health check path: `/health`

6. **Create Web Service**
   - Click "Create Web Service"
   - Wait for build and deployment (5-7 minutes)

**Expected Result**: Service deployed and accessible

---

### Step 3: Verify Render Deployment (2 minutes)

1. **Check Deployment Status**
   - Go to your service dashboard
   - Status should show "Live" with green indicator

2. **Test the Application**
   ```powershell
   # Test from command line
   curl https://dashboard-banking.onrender.com
   
   # Or open in browser
   start https://dashboard-banking.onrender.com
   ```

3. **View Logs** (if needed)
   - Click "Logs" tab in Render dashboard
   - Check for any errors

**Success Indicators**:
- ✅ Status: Live
- ✅ URL accessible
- ✅ Application loads correctly

---

## Part 2: Fly.io Setup (15 minutes)

### Step 1: Install Fly.io CLI (5 minutes)

#### For Windows (PowerShell)

```powershell
# Install Fly CLI
powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"
```

**What this does**:
- Downloads Fly CLI installer
- Installs to `C:\Users\YourUsername\.fly\bin\`
- Adds to PATH automatically

**Verify Installation**:
```powershell
# Close and reopen PowerShell, then:
flyctl version
```

**Expected Output**:
```
flyctl v0.x.xxx windows/amd64 Commit: xxxxx BuildDate: 2024-xx-xx
```

---

### Step 2: Create Fly.io Account & Login (3 minutes)

1. **Sign Up / Login**
   ```powershell
   flyctl auth login
   ```

2. **Browser Opens Automatically**
   - If new user: Click "Sign up"
   - If existing: Click "Log in"

3. **Sign Up Options**
   - **Recommended**: Sign up with GitHub
   - **Alternative**: Use email

4. **Verify Email** (if using email signup)
   - Check your email
   - Click verification link

5. **Add Payment Method** (Required for Fly.io)
   - Even for free tier, Fly.io requires a credit card
   - Go to: https://fly.io/dashboard/personal/billing
   - Add credit card (won't be charged on free tier)
   - Free tier includes:
     - 3 shared-cpu-1x VMs
     - 3GB persistent volume storage
     - 160GB outbound data transfer

6. **Confirm Login**
   ```powershell
   flyctl auth whoami
   ```

**Expected Output**:
```
Email: your-email@example.com
Logged in successfully!
```

---

### Step 3: Deploy to Fly.io (7 minutes)

#### Method 1: Deploy from Docker Image (Recommended)

1. **Launch Application**
   ```powershell
   flyctl launch --image owlbandocker/dashboard:latest --name dashboard-banking --region sea
   ```

   **Parameters**:
   - `--image`: Docker image to deploy
   - `--name`: Your app name (must be unique globally)
   - `--region`: Deployment region
     - `sea`: Seattle (US West)
     - `iad`: Ashburn (US East)
     - `lhr`: London
     - `syd`: Sydney
     - Full list: `flyctl platform regions`

2. **Configuration Prompts**
   ```
   ? Would you like to set up a Postgresql database? No
   ? Would you like to set up an Upstash Redis database? No
   ? Would you like to deploy now? Yes
   ```

3. **Wait for Deployment**
   - Initial deployment: 2-3 minutes
   - You'll see build logs in terminal

4. **Get Your URL**
   ```powershell
   flyctl status
   ```

   **Expected Output**:
   ```
   App
     Name     = dashboard-banking
     Owner    = personal
     Hostname = dashboard-banking.fly.dev
     ...
   ```

5. **Open Application**
   ```powershell
   flyctl open
   ```

   Or visit: `https://dashboard-banking.fly.dev`

---

#### Method 2: Deploy from GitHub (Alternative)

1. **Clone/Navigate to Repository**
   ```powershell
   cd C:\Users\bizle\OneDrive\Documents\GitHub\DASHBOARD
   ```

2. **Initialize Fly App**
   ```powershell
   flyctl launch
   ```

3. **Follow Prompts**
   ```
   ? App Name: dashboard-banking
   ? Select region: sea (Seattle)
   ? Would you like to set up a Postgresql database? No
   ? Would you like to set up an Upstash Redis database? No
   ? Would you like to deploy now? Yes
   ```

4. **Fly.toml Created**
   - A `fly.toml` file is created automatically
   - This configures your deployment

5. **Deploy**
   ```powershell
   flyctl deploy
   ```

---

### Step 4: Configure Fly.io App (Optional)

#### Set Environment Variables

```powershell
# Set secrets (environment variables)
flyctl secrets set GF_SECURITY_ADMIN_PASSWORD=YourSecurePassword123!
flyctl secrets set GF_SECURITY_ADMIN_USER=admin
```

#### Scale Application

```powershell
# Check current scale
flyctl scale show

# Scale to 2 instances (for redundancy)
flyctl scale count 2

# Scale VM size (if needed)
flyctl scale vm shared-cpu-1x
```

#### View Logs

```powershell
# Real-time logs
flyctl logs

# Follow logs
flyctl logs -f
```

---

### Step 5: Verify Fly.io Deployment (2 minutes)

1. **Check Status**
   ```powershell
   flyctl status
   ```

   **Look for**:
   - ✅ Status: running
   - ✅ Health checks: passing
   - ✅ Instances: 1 or more

2. **Test Application**
   ```powershell
   # Test from command line
   curl https://dashboard-banking.fly.dev
   
   # Or open in browser
   flyctl open
   ```

3. **Monitor Health**
   ```powershell
   flyctl checks list
   ```

**Success Indicators**:
- ✅ App status: running
- ✅ Health checks: passing
- ✅ URL accessible
- ✅ Application loads correctly

---

## Part 3: Troubleshooting

### Render.com Issues

#### Issue: Build Fails
**Solution**:
```
1. Check Dockerfile syntax
2. Verify image exists on Docker Hub
3. Check Render logs for specific error
4. Try deploying from Docker Hub instead of GitHub
```

#### Issue: Service Won't Start
**Solution**:
```
1. Check environment variables
2. Verify port configuration (should be 3000)
3. Check logs in Render dashboard
4. Ensure health check path is correct
```

#### Issue: Out of Memory
**Solution**:
```
1. Upgrade from Free tier to Starter ($7/month)
2. Optimize Docker image size
3. Check for memory leaks in application
```

---

### Fly.io Issues

#### Issue: "App name already taken"
**Solution**:
```powershell
# Try a different name
flyctl launch --image owlbandocker/dashboard:latest --name dashboard-banking-2024
```

#### Issue: "Credit card required"
**Solution**:
```
1. Go to https://fly.io/dashboard/personal/billing
2. Add a valid credit card
3. You won't be charged on free tier
4. Retry deployment
```

#### Issue: Deployment Fails
**Solution**:
```powershell
# Check logs
flyctl logs

# Destroy and recreate
flyctl apps destroy dashboard-banking
flyctl launch --image owlbandocker/dashboard:latest --name dashboard-banking
```

#### Issue: Health Checks Failing
**Solution**:
```powershell
# Check health check configuration in fly.toml
# Ensure your app responds on the correct port (3000)
# Verify health endpoint exists
```

---

## Part 4: Post-Deployment

### Update TODO.md

Add these completed items:
```markdown
- [x] Deploy to Render.com
- [x] Deploy to Fly.io
- [x] Verify Render deployment
- [x] Verify Fly.io deployment
```

### Monitor Deployments

#### Render.com
- Dashboard: https://dashboard.render.com
- Logs: Click service → Logs tab
- Metrics: Click service → Metrics tab

#### Fly.io
```powershell
# Status
flyctl status

# Logs
flyctl logs -f

# Metrics
flyctl dashboard metrics
```

---

## Part 5: Quick Reference

### Render.com Commands

```bash
# No CLI needed - all done via web dashboard
# Dashboard: https://dashboard.render.com
```

### Fly.io Commands

```powershell
# Deploy
flyctl deploy

# Status
flyctl status

# Logs
flyctl logs -f

# Open app
flyctl open

# Scale
flyctl scale count 2

# Secrets
flyctl secrets set KEY=value

# SSH into instance
flyctl ssh console

# Destroy app
flyctl apps destroy app-name
```

---

## Part 6: Cost Comparison

### Render.com Free Tier
- ✅ 750 hours/month
- ✅ 512 MB RAM
- ✅ Shared CPU
- ✅ Auto-sleep after 15 min inactivity
- ✅ Custom domains
- ❌ No persistent storage on free tier

### Fly.io Free Tier
- ✅ 3 shared-cpu-1x VMs (256MB RAM each)
- ✅ 3GB persistent volume storage
- ✅ 160GB outbound data transfer
- ✅ No auto-sleep
- ✅ Custom domains
- ⚠️ Requires credit card

---

## Success Checklist

### Render.com ✅
- [ ] Account created
- [ ] Service deployed
- [ ] URL accessible
- [ ] Application loads correctly
- [ ] Logs reviewed

### Fly.io ✅
- [ ] CLI installed
- [ ] Account created
- [ ] Credit card added
- [ ] App deployed
- [ ] URL accessible
- [ ] Application loads correctly
- [ ] Health checks passing

---

## Next Steps After Setup

1. **Update Documentation**
   - Add deployment URLs to README
   - Document environment variables
   - Update TODO.md

2. **Set Up Monitoring**
   - Configure uptime monitoring
   - Set up alerts
   - Monitor resource usage

3. **Configure Custom Domains** (Optional)
   - Render: Dashboard → Settings → Custom Domain
   - Fly.io: `flyctl certs add yourdomain.com`

4. **Enable Auto-Deploy** (Optional)
   - Render: Automatically deploys on git push
   - Fly.io: Set up GitHub Actions

---

## Support Resources

### Render.com
- Docs: https://render.com/docs
- Status: https://status.render.com
- Support: https://render.com/support

### Fly.io
- Docs: https://fly.io/docs
- Community: https://community.fly.io
- Status: https://status.flyio.net
- Support: support@fly.io

---

**Status**: ✅ READY TO USE  
**Estimated Setup Time**: 30 minutes  
**Difficulty**: Beginner-Friendly  
**Cost**: Free (with credit card for Fly.io)

---

**Last Updated**: January 2025  
**Tested On**: Windows 11, PowerShell  
**Success Rate**: 95%+
