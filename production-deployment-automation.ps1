# Production Deployment Automation Script
# This script automates the deployment process to production environments

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('all', 'docker', 'vercel', 'heroku', 'render', 'flyio')]
    [string]$Platform = 'all',
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipTests,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PRODUCTION DEPLOYMENT AUTOMATION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$ErrorActionPreference = "Stop"
$deploymentLog = "deployment-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

function Write-Log {
    param($Message, $Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    Write-Host $logMessage
    Add-Content -Path $deploymentLog -Value $logMessage
}

function Test-Prerequisites {
    Write-Log "Checking prerequisites..." "INFO"
    
    # Check Docker
    try {
        docker --version | Out-Null
        Write-Log "✓ Docker installed" "SUCCESS"
    } catch {
        Write-Log "✗ Docker not found. Please install Docker." "ERROR"
        return $false
    }
    
    # Check Git
    try {
        git --version | Out-Null
        Write-Log "✓ Git installed" "SUCCESS"
    } catch {
        Write-Log "✗ Git not found. Please install Git." "ERROR"
        return $false
    }
    
    # Check Node.js (for Vercel)
    if ($Platform -eq 'all' -or $Platform -eq 'vercel') {
        try {
            node --version | Out-Null
            Write-Log "✓ Node.js installed" "SUCCESS"
        } catch {
            Write-Log "⚠ Node.js not found. Vercel deployment will be skipped." "WARN"
        }
    }
    
    return $true
}

function Run-Tests {
    if ($SkipTests) {
        Write-Log "Skipping tests (--SkipTests flag set)" "WARN"
        return $true
    }
    
    Write-Log "Running test suite..." "INFO"
    
    try {
        & .\run-complete-test-suite.ps1
        Write-Log "✓ All tests passed" "SUCCESS"
        return $true
    } catch {
        Write-Log "✗ Tests failed. Deployment aborted." "ERROR"
        return $false
    }
}

function Deploy-ToDocker {
    Write-Log "Deploying to Docker Hub..." "INFO"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would build and push Docker images" "INFO"
        return $true
    }
    
    try {
        # Build images
        Write-Log "Building Docker images..." "INFO"
        docker compose -f quickstart/docker-compose.yml build
        
        # Tag images
        Write-Log "Tagging images..." "INFO"
        docker tag quickstart-frontend owlbandocker/plaid-frontend:latest
        docker tag quickstart-java owlbandocker/plaid-backend:latest
        
        # Push to Docker Hub
        Write-Log "Pushing to Docker Hub..." "INFO"
        docker push owlbandocker/plaid-frontend:latest
        docker push owlbandocker/plaid-backend:latest
        
        Write-Log "✓ Docker deployment complete" "SUCCESS"
        return $true
    } catch {
        Write-Log "✗ Docker deployment failed: $_" "ERROR"
        return $false
    }
}

function Deploy-ToVercel {
    Write-Log "Deploying to Vercel..." "INFO"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would deploy to Vercel" "INFO"
        return $true
    }
    
    try {
        # Check if Vercel CLI is installed
        try {
            vercel --version | Out-Null
        } catch {
            Write-Log "Installing Vercel CLI..." "INFO"
            npm install -g vercel
        }
        
        # Deploy
        Write-Log "Deploying to Vercel..." "INFO"
        vercel --prod --yes
        
        Write-Log "✓ Vercel deployment complete" "SUCCESS"
        return $true
    } catch {
        Write-Log "✗ Vercel deployment failed: $_" "ERROR"
        return $false
    }
}

function Deploy-ToHeroku {
    Write-Log "Deploying to Heroku..." "INFO"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would deploy to Heroku" "INFO"
        return $true
    }
    
    try {
        # Check if Heroku CLI is installed
        try {
            heroku --version | Out-Null
        } catch {
            Write-Log "✗ Heroku CLI not found. Please install it first." "ERROR"
            return $false
        }
        
        # Deploy
        Write-Log "Pushing to Heroku..." "INFO"
        git push heroku main
        
        Write-Log "✓ Heroku deployment complete" "SUCCESS"
        return $true
    } catch {
        Write-Log "✗ Heroku deployment failed: $_" "ERROR"
        return $false
    }
}

function Deploy-ToRender {
    Write-Log "Deploying to Render.com..." "INFO"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would deploy to Render.com" "INFO"
        return $true
    }
    
    Write-Log "Render.com deployment requires manual setup via dashboard" "INFO"
    Write-Log "See RENDER_FLYIO_SETUP_GUIDE.md for instructions" "INFO"
    return $true
}

function Deploy-ToFlyIO {
    Write-Log "Deploying to Fly.io..." "INFO"
    
    if ($DryRun) {
        Write-Log "[DRY RUN] Would deploy to Fly.io" "INFO"
        return $true
    }
    
    try {
        # Check if Fly CLI is installed
        try {
            fly version | Out-Null
        } catch {
            Write-Log "✗ Fly CLI not found. Please install it first." "ERROR"
            return $false
        }
        
        # Deploy
        Write-Log "Deploying to Fly.io..." "INFO"
        fly deploy
        
        Write-Log "✓ Fly.io deployment complete" "SUCCESS"
        return $true
    } catch {
        Write-Log "✗ Fly.io deployment failed: $_" "ERROR"
        return $false
    }
}

# Main execution
Write-Log "Starting deployment process..." "INFO"
Write-Log "Platform: $Platform" "INFO"
Write-Log "Dry Run: $DryRun" "INFO"
Write-Log "Skip Tests: $SkipTests" "INFO"
Write-Host ""

# Check prerequisites
if (-not (Test-Prerequisites)) {
    Write-Log "Prerequisites check failed. Exiting." "ERROR"
    exit 1
}

# Run tests
if (-not (Run-Tests)) {
    Write-Log "Tests failed. Exiting." "ERROR"
    exit 1
}

# Deploy to platforms
$deploymentResults = @{}

if ($Platform -eq 'all' -or $Platform -eq 'docker') {
    $deploymentResults['Docker'] = Deploy-ToDocker
}

if ($Platform -eq 'all' -or $Platform -eq 'vercel') {
    $deploymentResults['Vercel'] = Deploy-ToVercel
}

if ($Platform -eq 'all' -or $Platform -eq 'heroku') {
    $deploymentResults['Heroku'] = Deploy-ToHeroku
}

if ($Platform -eq 'all' -or $Platform -eq 'render') {
    $deploymentResults['Render'] = Deploy-ToRender
}

if ($Platform -eq 'all' -or $Platform -eq 'flyio') {
    $deploymentResults['FlyIO'] = Deploy-ToFlyIO
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DEPLOYMENT SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($platform in $deploymentResults.Keys) {
    $status = if ($deploymentResults[$platform]) { "✓ SUCCESS" } else { "✗ FAILED" }
    $color = if ($deploymentResults[$platform]) { "Green" } else { "Red" }
    
    Write-Host "$platform : $status" -ForegroundColor $color
    
    if ($deploymentResults[$platform]) {
        $successCount++
    } else {
        $failCount++
    }
}

Write-Host ""
Write-Host "Total: $($deploymentResults.Count) platforms" -ForegroundColor Cyan
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host ""
Write-Host "Deployment log saved to: $deploymentLog" -ForegroundColor Cyan
Write-Host ""

if ($failCount -eq 0) {
    Write-Log "✓ All deployments completed successfully!" "SUCCESS"
    exit 0
} else {
    Write-Log "⚠ Some deployments failed. Check log for details." "WARN"
    exit 1
}
