# Banking Dashboard Deployment Script
# PowerShell script for Windows

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('render', 'fly', 'railway', 'docker', 'heroku', 'all')]
    [string]$Platform = 'render',
    
    [Parameter(Mandatory=$false)]
    [string]$AppName = 'grafana-banking-dashboard'
)

Write-Host "🚀 Banking Dashboard Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if command exists
function Test-Command {
    param($Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

# Function to deploy to Render
function Invoke-RenderDeployment {
    Write-Host "📦 Deploying to Render.com..." -ForegroundColor Green
    Write-Host "Please follow these steps:" -ForegroundColor Yellow
    Write-Host "1. Go to https://render.com" -ForegroundColor White
    Write-Host "2. Sign up/Login with GitHub" -ForegroundColor White
    Write-Host "3. Click 'New +' → 'Web Service'" -ForegroundColor White
    Write-Host "4. Connect this repository" -ForegroundColor White
    Write-Host "5. Render will auto-detect render.yaml" -ForegroundColor White
    Write-Host "6. Click 'Create Web Service'" -ForegroundColor White
    Write-Host ""
    Write-Host "✅ Your dashboard will be live at: https://$AppName.onrender.com" -ForegroundColor Green
}

# Function to deploy to Fly.io
function Invoke-FlyDeployment {
    Write-Host "📦 Deploying to Fly.io..." -ForegroundColor Green
    
    if (-not (Test-Command flyctl)) {
        Write-Host "Installing Fly CLI..." -ForegroundColor Yellow
        Invoke-WebRequest https://fly.io/install.ps1 -UseBasicParsing | Invoke-Expression
        Write-Host "✅ Fly CLI installed" -ForegroundColor Green
    }
    
    Write-Host "Logging in to Fly.io..." -ForegroundColor Yellow
    flyctl auth login
    
    Write-Host "Launching app..." -ForegroundColor Yellow
    flyctl launch --config fly.toml --now
    
    Write-Host "✅ Deployed to Fly.io!" -ForegroundColor Green
    flyctl open
}

# Function to deploy to Railway
function Invoke-RailwayDeployment {
    Write-Host "📦 Deploying to Railway.app..." -ForegroundColor Green
    
    if (-not (Test-Command railway)) {
        Write-Host "Installing Railway CLI..." -ForegroundColor Yellow
        npm install -g @railway/cli
        Write-Host "✅ Railway CLI installed" -ForegroundColor Green
    }
    
    Write-Host "Logging in to Railway..." -ForegroundColor Yellow
    railway login
    
    Write-Host "Initializing project..." -ForegroundColor Yellow
    railway init
    
    Write-Host "Deploying..." -ForegroundColor Yellow
    railway up
    
    Write-Host "Getting domain..." -ForegroundColor Yellow
    railway domain
    
    Write-Host "✅ Deployed to Railway!" -ForegroundColor Green
}

# Function to build and push Docker image
function Invoke-DockerDeployment {
    Write-Host "📦 Building and pushing Docker image..." -ForegroundColor Green
    
    if (-not (Test-Command docker)) {
        Write-Host "❌ Docker is not installed. Please install Docker Desktop." -ForegroundColor Red
        Write-Host "Download from: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
        return
    }
    
    Write-Host "Building Docker image..." -ForegroundColor Yellow
    docker build -t owlbandocker/dashboard:latest .
    
    Write-Host "Logging in to Docker Hub..." -ForegroundColor Yellow
    docker login
    
    Write-Host "Pushing to Docker Hub..." -ForegroundColor Yellow
    docker push owlbandocker/dashboard:latest
    
    Write-Host "✅ Docker image pushed successfully!" -ForegroundColor Green
    Write-Host "Image: owlbandocker/dashboard:latest" -ForegroundColor Cyan
}

# Function to deploy to Heroku
function Invoke-HerokuDeployment {
    Write-Host "📦 Deploying to Heroku..." -ForegroundColor Green
    
    if (-not (Test-Command heroku)) {
        Write-Host "❌ Heroku CLI is not installed." -ForegroundColor Red
        return
    }
    
    Write-Host "Logging in to Heroku..." -ForegroundColor Yellow
    heroku login
    
    Write-Host "Creating Heroku app..." -ForegroundColor Yellow
    heroku create $AppName --stack container
    
    Write-Host "Logging in to Heroku Container Registry..." -ForegroundColor Yellow
    heroku container:login
    
    Write-Host "Building and pushing container..." -ForegroundColor Yellow
    heroku container:push web -a $AppName
    
    Write-Host "Releasing container..." -ForegroundColor Yellow
    heroku container:release web -a $AppName
    
    Write-Host "Setting environment variables..." -ForegroundColor Yellow
    heroku config:set GF_SECURITY_ADMIN_PASSWORD=admin123 -a $AppName
    
    Write-Host "✅ Deployed to Heroku!" -ForegroundColor Green
    heroku open -a $AppName
}

# Function to test locally
function Test-Local {
    Write-Host "🧪 Testing locally with Docker..." -ForegroundColor Green
    
    if (-not (Test-Command docker)) {
        Write-Host "❌ Docker is not installed." -ForegroundColor Red
        return
    }
    
    Write-Host "Building Docker image..." -ForegroundColor Yellow
    docker build -t grafana-banking-dashboard:local .
    
    Write-Host "Running container..." -ForegroundColor Yellow
    docker run -d -p 3000:3000 --name grafana-banking-dashboard grafana-banking-dashboard:local
    
    Write-Host "✅ Dashboard running locally!" -ForegroundColor Green
    Write-Host "Access at: http://localhost:3000" -ForegroundColor Cyan
    Write-Host "Username: admin" -ForegroundColor White
    Write-Host "Password: admin (change after first login)" -ForegroundColor White
    
    Start-Sleep -Seconds 3
    Start-Process "http://localhost:3000"
}

# Main deployment logic
Write-Host "Selected Platform: $Platform" -ForegroundColor Cyan
Write-Host ""

switch ($Platform) {
    'render' { Invoke-RenderDeployment }
    'fly' { Invoke-FlyDeployment }
    'railway' { Invoke-RailwayDeployment }
    'docker' { Invoke-DockerDeployment }
    'heroku' { Invoke-HerokuDeployment }
    'all' {
        Write-Host "Deploying to all platforms..." -ForegroundColor Magenta
        Invoke-DockerDeployment
        Invoke-RenderDeployment
        Invoke-FlyDeployment
        Invoke-RailwayDeployment
        Invoke-HerokuDeployment
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "🎉 Deployment process completed!" -ForegroundColor Green
Write-Host ""
Write-Host "📚 For more information, see:" -ForegroundColor Yellow
Write-Host "  - QUICK_DEPLOY.md" -ForegroundColor White
Write-Host "  - DEPLOYMENT_GUIDE.md" -ForegroundColor White
Write-Host ""
Write-Host "🔐 Security Reminder:" -ForegroundColor Red
Write-Host "  Change the default admin password after first login!" -ForegroundColor Yellow
Write-Host ""
