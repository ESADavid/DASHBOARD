# Complete Optional Tasks - Interactive Guide
# This script helps you complete all optional TODO items

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Optional Tasks Completion Guide" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "This guide will help you complete the following optional tasks:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Set Heroku environment variables" -ForegroundColor White
Write-Host "2. Configure Heroku custom domain (if you have one)" -ForegroundColor White
Write-Host "3. Set up GitHub secrets for CI/CD" -ForegroundColor White
Write-Host "4. Deploy to Fly.io" -ForegroundColor White
Write-Host "5. Deploy to Render.com" -ForegroundColor White
Write-Host "6. Set up Kubernetes deployment (optional)" -ForegroundColor White
Write-Host ""

# Task 1: Heroku Environment Variables
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 1: Heroku Environment Variables" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Optional (not required for basic functionality)" -ForegroundColor Gray
Write-Host ""
Write-Host "To set a secure admin password for your Heroku deployment:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Run this command (replace YOUR_SECURE_PASSWORD with your chosen password):" -ForegroundColor White
Write-Host ""
Write-Host "  heroku config:set GF_SECURITY_ADMIN_PASSWORD=YOUR_SECURE_PASSWORD -a esaowl" -ForegroundColor Cyan
Write-Host ""

$setHerokuEnv = Read-Host "Would you like to set the Heroku password now? (y/n)"
if ($setHerokuEnv -eq "y") {
    $password = Read-Host "Enter your desired admin password" -AsSecureString
    $passwordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    
    Write-Host "Setting Heroku environment variable..." -ForegroundColor Yellow
    heroku config:set GF_SECURITY_ADMIN_PASSWORD=$passwordPlain -a esaowl
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Heroku password set successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to set Heroku password" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️  Skipped - You can set this later" -ForegroundColor Gray
}

Write-Host ""

# Task 2: Heroku Custom Domain
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 2: Heroku Custom Domain" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Optional (requires owning a domain)" -ForegroundColor Gray
Write-Host ""
Write-Host "To add a custom domain to your Heroku app:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Run: heroku domains:add yourdomain.com -a esaowl" -ForegroundColor White
Write-Host "2. Configure your DNS provider with the provided CNAME" -ForegroundColor White
Write-Host "3. SSL will be automatically provisioned" -ForegroundColor White
Write-Host ""

$setDomain = Read-Host "Do you have a custom domain to add? (y/n)"
if ($setDomain -eq "y") {
    $domain = Read-Host "Enter your domain name (e.g., dashboard.yourdomain.com)"
    
    Write-Host "Adding domain to Heroku..." -ForegroundColor Yellow
    heroku domains:add $domain -a esaowl
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Domain added! Configure your DNS as instructed above" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to add domain" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️  Skipped - You can add a domain later" -ForegroundColor Gray
}

Write-Host ""

# Task 3: GitHub Secrets
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 3: GitHub Secrets for CI/CD" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Optional (enables automated deployments)" -ForegroundColor Gray
Write-Host ""
Write-Host "To enable GitHub Actions deployments, you need to add secrets:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Required secrets:" -ForegroundColor White
Write-Host "  - DOCKER_USERNAME (your Docker Hub username)" -ForegroundColor Cyan
Write-Host "  - DOCKER_PASSWORD (your Docker Hub password/token)" -ForegroundColor Cyan
Write-Host "  - HEROKU_API_KEY (from heroku auth:token)" -ForegroundColor Cyan
Write-Host "  - RENDER_API_KEY (from Render.com dashboard)" -ForegroundColor Cyan
Write-Host "  - FLY_API_TOKEN (from flyctl auth token)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Detailed instructions: See GITHUB_SECRETS_SETUP.md" -ForegroundColor Yellow
Write-Host ""

$openSecretsGuide = Read-Host "Open the GitHub Secrets setup guide? (y/n)"
if ($openSecretsGuide -eq "y") {
    Start-Process "GITHUB_SECRETS_SETUP.md"
    Write-Host "✅ Guide opened" -ForegroundColor Green
} else {
    Write-Host "⏭️  Skipped - You can set up secrets later" -ForegroundColor Gray
}

Write-Host ""

# Task 4: Deploy to Fly.io
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 4: Deploy to Fly.io" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Ready to deploy (requires credit card)" -ForegroundColor Gray
Write-Host ""
Write-Host "Prerequisites:" -ForegroundColor Yellow
Write-Host "  ✅ Fly.io CLI installed" -ForegroundColor Green
Write-Host "  ✅ fly.toml configured" -ForegroundColor Green
Write-Host "  ⚠️  Credit card required (free tier won't charge)" -ForegroundColor Yellow
Write-Host ""

$deployFly = Read-Host "Deploy to Fly.io now? (y/n)"
if ($deployFly -eq "y") {
    Write-Host ""
    Write-Host "Launching deployment script..." -ForegroundColor Yellow
    Write-Host "Select option 1 when prompted" -ForegroundColor Cyan
    Write-Host ""
    Start-Sleep -Seconds 2
    .\deploy-to-platforms.ps1
} else {
    Write-Host "⏭️  Skipped - Run .\deploy-to-platforms.ps1 later and select option 1" -ForegroundColor Gray
}

Write-Host ""

# Task 5: Deploy to Render.com
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 5: Deploy to Render.com" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Ready to deploy (no credit card required)" -ForegroundColor Gray
Write-Host ""
Write-Host "Prerequisites:" -ForegroundColor Yellow
Write-Host "  ✅ render.yaml configured" -ForegroundColor Green
Write-Host "  ✅ Setup guide created" -ForegroundColor Green
Write-Host "  ℹ️  No credit card required for free tier" -ForegroundColor Cyan
Write-Host ""

$deployRender = Read-Host "Deploy to Render.com now? (y/n)"
if ($deployRender -eq "y") {
    Write-Host ""
    Write-Host "Opening Render.com and setup guide..." -ForegroundColor Yellow
    Start-Process "https://render.com"
    Start-Process "RENDER_FLYIO_SETUP_GUIDE.md"
    Write-Host "✅ Follow the guide to complete deployment" -ForegroundColor Green
} else {
    Write-Host "⏭️  Skipped - Run .\deploy-to-platforms.ps1 later and select option 2" -ForegroundColor Gray
}

Write-Host ""

# Task 6: Kubernetes Deployment
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Task 6: Kubernetes Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Current Status: Optional alternative deployment method" -ForegroundColor Gray
Write-Host ""
Write-Host "This is an advanced option for local Kubernetes testing" -ForegroundColor Yellow
Write-Host ""
Write-Host "Prerequisites:" -ForegroundColor Yellow
Write-Host "  - minikube installed" -ForegroundColor White
Write-Host "  - kubectl installed" -ForegroundColor White
Write-Host ""

$deployK8s = Read-Host "Set up Kubernetes deployment? (y/n)"
if ($deployK8s -eq "y") {
    Write-Host ""
    Write-Host "Starting minikube..." -ForegroundColor Yellow
    minikube start
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Minikube started" -ForegroundColor Green
        
        Write-Host "Applying deployment..." -ForegroundColor Yellow
        kubectl apply -f deployment.yaml
        kubectl apply -f service.yaml
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Kubernetes deployment complete" -ForegroundColor Green
            Write-Host ""
            Write-Host "Get service URL:" -ForegroundColor Yellow
            minikube service banking-dashboard-service --url
        } else {
            Write-Host "❌ Deployment failed" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to start minikube" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️  Skipped - Kubernetes deployment is optional" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Optional Tasks Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Tasks completed! Here's what you can do next:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Test your deployments:" -ForegroundColor White
Write-Host "   - Heroku: https://esaowl.herokuapp.com" -ForegroundColor Cyan
Write-Host "   - Vercel: https://owlban-website.vercel.app" -ForegroundColor Cyan
Write-Host "   - Fly.io: https://banking-dashboard.fly.dev (if deployed)" -ForegroundColor Cyan
Write-Host "   - Render: https://banking-dashboard.onrender.com (if deployed)" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Set up monitoring and alerts" -ForegroundColor White
Write-Host "3. Configure custom domains" -ForegroundColor White
Write-Host "4. Enable auto-deployments via GitHub Actions" -ForegroundColor White
Write-Host ""
Write-Host "For detailed guides, see:" -ForegroundColor Yellow
Write-Host "  - FLY_RENDER_NEXT_STEPS.md" -ForegroundColor Cyan
Write-Host "  - GITHUB_SECRETS_SETUP.md" -ForegroundColor Cyan
Write-Host "  - RENDER_FLYIO_SETUP_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
