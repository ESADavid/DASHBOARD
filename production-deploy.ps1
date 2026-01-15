# Production Deployment Script
# This script helps set up and deploy the Banking Dashboard to production

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('setup', 'docker', 'render', 'fly', 'railway', 'all', 'status')]
    [string]$Action = 'setup',
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipTests = $false
)

# Colors for output
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Cyan"
$WarningColor = "Yellow"

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Write-Step {
    param([string]$Message)
    Write-ColorOutput "`n==> $Message" $InfoColor
}

function Write-Success {
    param([string]$Message)
    Write-ColorOutput "✓ $Message" $SuccessColor
}

function Write-Error {
    param([string]$Message)
    Write-ColorOutput "✗ $Message" $ErrorColor
}

function Write-Warning {
    param([string]$Message)
    Write-ColorOutput "⚠ $Message" $WarningColor
}

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

function Show-Banner {
    Write-ColorOutput @"

╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     Banking Dashboard - Production Deployment             ║
║                                                           ║
║     Automated deployment to multiple platforms            ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

"@ $InfoColor
}

function Test-Prerequisites {
    Write-Step "Checking prerequisites..."
    
    $allGood = $true
    
    # Check Git
    if (Test-Command "git") {
        Write-Success "Git is installed"
    } else {
        Write-Error "Git is not installed"
        $allGood = $false
    }
    
    # Check Docker
    if (Test-Command "docker") {
        Write-Success "Docker is installed"
        try {
            docker ps | Out-Null
            Write-Success "Docker daemon is running"
        } catch {
            Write-Warning "Docker is installed but daemon is not running"
            Write-ColorOutput "  Please start Docker Desktop" $WarningColor
        }
    } else {
        Write-Warning "Docker is not installed (required for local testing)"
    }
    
    # Check GitHub CLI (optional)
    if (Test-Command "gh") {
        Write-Success "GitHub CLI is installed"
    } else {
        Write-Warning "GitHub CLI is not installed (optional)"
    }
    
    return $allGood
}

function Setup-Environment {
    Write-Step "Setting up production environment..."
    
    # Check if .env.production exists
    if (Test-Path ".env.production") {
        Write-Warning ".env.production already exists"
        $overwrite = Read-Host "Do you want to overwrite it? (y/N)"
        if ($overwrite -ne 'y') {
            Write-ColorOutput "Keeping existing .env.production" $InfoColor
            return
        }
    }
    
    # Copy example file
    if (Test-Path ".env.production.example") {
        Copy-Item ".env.production.example" ".env.production"
        Write-Success "Created .env.production from example"
        Write-ColorOutput "`nIMPORTANT: Edit .env.production and fill in your values!" $WarningColor
        Write-ColorOutput "File location: $(Get-Location)\.env.production" $InfoColor
        
        # Ask if user wants to open the file
        $openFile = Read-Host "`nDo you want to open .env.production now? (Y/n)"
        if ($openFile -ne 'n') {
            notepad ".env.production"
        }
    } else {
        Write-Error ".env.production.example not found"
    }
}

function Deploy-Docker {
    Write-Step "Deploying to Docker Hub..."
    
    # Check if logged in to Docker
    Write-ColorOutput "Checking Docker Hub authentication..." $InfoColor
    $dockerUser = docker info 2>&1 | Select-String "Username:"
    
    if (-not $dockerUser) {
        Write-Warning "Not logged in to Docker Hub"
        Write-ColorOutput "Please run: docker login" $InfoColor
        return $false
    }
    
    Write-Success "Logged in to Docker Hub"
    
    # Build image
    Write-Step "Building Docker image..."
    $imageName = "owlbandocker/dashboard"
    $imageTag = "latest"
    
    docker build -t "${imageName}:${imageTag}" .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Docker image built successfully"
    } else {
        Write-Error "Docker build failed"
        return $false
    }
    
    # Test image locally (optional)
    if (-not $SkipTests) {
        Write-Step "Testing image locally..."
        Write-ColorOutput "Starting container on port 3000..." $InfoColor
        
        docker run -d --name test-dashboard -p 3000:3000 "${imageName}:${imageTag}"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Container started successfully"
            Write-ColorOutput "Testing at http://localhost:3000..." $InfoColor
            Start-Sleep -Seconds 5
            
            try {
                $response = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 10 -UseBasicParsing
                if ($response.StatusCode -eq 200) {
                    Write-Success "Health check passed"
                }
            } catch {
                Write-Warning "Health check failed, but continuing..."
            }
            
            # Stop and remove test container
            docker stop test-dashboard | Out-Null
            docker rm test-dashboard | Out-Null
            Write-ColorOutput "Test container cleaned up" $InfoColor
        }
    }
    
    # Push to Docker Hub
    Write-Step "Pushing to Docker Hub..."
    docker push "${imageName}:${imageTag}"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Image pushed to Docker Hub successfully"
        Write-ColorOutput "`nImage: ${imageName}:${imageTag}" $SuccessColor
        return $true
    } else {
        Write-Error "Failed to push image to Docker Hub"
        return $false
    }
}

function Deploy-Render {
    Write-Step "Deploying to Render.com..."
    
    # Check for Render API key
    if (-not $env:RENDER_API_KEY) {
        Write-Warning "RENDER_API_KEY environment variable not set"
        Write-ColorOutput "Please set it or configure secrets in GitHub" $InfoColor
        return $false
    }
    
    Write-ColorOutput "Triggering Render deployment..." $InfoColor
    Write-ColorOutput "This will be done via GitHub Actions" $InfoColor
    Write-Success "Render deployment configured"
    
    return $true
}

function Deploy-Fly {
    Write-Step "Deploying to Fly.io..."
    
    if (-not (Test-Command "flyctl")) {
        Write-Warning "Fly CLI not installed"
        Write-ColorOutput "Install with: iwr https://fly.io/install.ps1 -useb | iex" $InfoColor
        return $false
    }
    
    Write-ColorOutput "Deploying to Fly.io..." $InfoColor
    flyctl deploy
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Deployed to Fly.io successfully"
        return $true
    } else {
        Write-Error "Fly.io deployment failed"
        return $false
    }
}

function Deploy-Railway {
    Write-Step "Deploying to Railway..."
    
    if (-not (Test-Command "railway")) {
        Write-Warning "Railway CLI not installed"
        Write-ColorOutput "Install from: https://docs.railway.app/develop/cli" $InfoColor
        return $false
    }
    
    Write-ColorOutput "Deploying to Railway..." $InfoColor
    railway up
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Deployed to Railway successfully"
        return $true
    } else {
        Write-Error "Railway deployment failed"
        return $false
    }
}

function Show-Status {
    Write-Step "Checking deployment status..."
    
    Write-ColorOutput "`nGitHub Actions:" $InfoColor
    Write-ColorOutput "  https://github.com/ESADavid/DASHBOARD/actions" $InfoColor
    
    Write-ColorOutput "`nDocker Hub:" $InfoColor
    Write-ColorOutput "  https://hub.docker.com/r/owlbandocker/dashboard" $InfoColor
    
    Write-ColorOutput "`nPlatform Dashboards:" $InfoColor
    Write-ColorOutput "  Render: https://dashboard.render.com" $InfoColor
    Write-ColorOutput "  Fly.io: https://fly.io/dashboard" $InfoColor
    Write-ColorOutput "  Railway: https://railway.app/dashboard" $InfoColor
    Write-ColorOutput "  Heroku: https://dashboard.heroku.com" $InfoColor
}

function Deploy-All {
    Write-Step "Deploying to all configured platforms..."
    
    $results = @{}
    
    # Docker Hub (required)
    $results['Docker Hub'] = Deploy-Docker
    
    if ($results['Docker Hub']) {
        # Only proceed with other platforms if Docker succeeds
        $results['Render'] = Deploy-Render
        $results['Fly.io'] = Deploy-Fly
        $results['Railway'] = Deploy-Railway
    }
    
    # Show summary
    Write-Step "Deployment Summary"
    foreach ($platform in $results.Keys) {
        if ($results[$platform]) {
            Write-Success "$platform - SUCCESS"
        } else {
            Write-Error "$platform - FAILED"
        }
    }
}

# Main execution
Show-Banner

if (-not (Test-Prerequisites)) {
    Write-Error "`nPrerequisites check failed. Please install missing tools."
    exit 1
}

switch ($Action) {
    'setup' {
        Setup-Environment
    }
    'docker' {
        Deploy-Docker
    }
    'render' {
        Deploy-Render
    }
    'fly' {
        Deploy-Fly
    }
    'railway' {
        Deploy-Railway
    }
    'all' {
        Deploy-All
    }
    'status' {
        Show-Status
    }
}

Write-ColorOutput "`n✓ Script completed!" $SuccessColor
Write-ColorOutput "`nFor more information, see PRODUCTION_DEPLOYMENT_SETUP.md" $InfoColor
