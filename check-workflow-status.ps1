# GitHub Actions Workflow Status Checker
# This script helps you check the workflow status without browser access

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "GitHub Actions Workflow Checker" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Repository information
$repo = "ESADavid/DASHBOARD"
$workflowFile = "deploy-multi-platform.yml"

Write-Host "Repository: $repo" -ForegroundColor Yellow
Write-Host "Workflow: $workflowFile" -ForegroundColor Yellow
Write-Host ""

# Check if gh CLI is installed
Write-Host "Checking GitHub CLI installation..." -ForegroundColor Green
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if (-not $ghInstalled) {
    Write-Host "❌ GitHub CLI (gh) is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "To install GitHub CLI:" -ForegroundColor Yellow
    Write-Host "  winget install --id GitHub.cli" -ForegroundColor White
    Write-Host ""
    Write-Host "Or download from: https://cli.github.com/" -ForegroundColor White
    Write-Host ""
    Write-Host "After installation, run: gh auth login" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host "✅ GitHub CLI is installed" -ForegroundColor Green
Write-Host ""

# Check if authenticated
Write-Host "Checking GitHub authentication..." -ForegroundColor Green
$authStatus = gh auth status 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not authenticated with GitHub" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please run: gh auth login" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host "✅ Authenticated with GitHub" -ForegroundColor Green
Write-Host ""

# Get latest workflow runs
Write-Host "Fetching latest workflow runs..." -ForegroundColor Green
Write-Host ""

try {
    $runs = gh run list --repo $repo --workflow $workflowFile --limit 5 --json databaseId,status,conclusion,createdAt,headBranch,event,displayTitle | ConvertFrom-Json
    
    if ($runs.Count -eq 0) {
        Write-Host "⚠️  No workflow runs found" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "This could mean:" -ForegroundColor Yellow
        Write-Host "  1. The workflow hasn't been triggered yet" -ForegroundColor White
        Write-Host "  2. The workflow file name is different" -ForegroundColor White
        Write-Host "  3. The repository doesn't have Actions enabled" -ForegroundColor White
        Write-Host ""
        exit 0
    }
    
    Write-Host "📊 Latest Workflow Runs:" -ForegroundColor Cyan
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host ""
    
    $runNumber = 1
    foreach ($run in $runs) {
        Write-Host "Run #$runNumber" -ForegroundColor Yellow
        Write-Host "  ID: $($run.databaseId)" -ForegroundColor White
        Write-Host "  Title: $($run.displayTitle)" -ForegroundColor White
        Write-Host "  Branch: $($run.headBranch)" -ForegroundColor White
        Write-Host "  Event: $($run.event)" -ForegroundColor White
        Write-Host "  Created: $($run.createdAt)" -ForegroundColor White
        
        # Status with color
        $statusColor = "White"
        $statusIcon = "⏳"
        
        if ($run.status -eq "completed") {
            if ($run.conclusion -eq "success") {
                $statusColor = "Green"
                $statusIcon = "✅"
            } elseif ($run.conclusion -eq "failure") {
                $statusColor = "Red"
                $statusIcon = "❌"
            } elseif ($run.conclusion -eq "cancelled") {
                $statusColor = "Yellow"
                $statusIcon = "⚠️"
            }
            Write-Host "  Status: $statusIcon $($run.status) - $($run.conclusion)" -ForegroundColor $statusColor
        } else {
            Write-Host "  Status: $statusIcon $($run.status)" -ForegroundColor Yellow
        }
        
        Write-Host ""
        $runNumber++
    }
    
    # Get details of the most recent run
    $latestRun = $runs[0]
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host "Latest Run Details" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Getting job details..." -ForegroundColor Green
    $jobs = gh run view $latestRun.databaseId --repo $repo --json jobs | ConvertFrom-Json
    
    Write-Host ""
    Write-Host "📋 Jobs Status:" -ForegroundColor Cyan
    Write-Host ""
    
    foreach ($job in $jobs.jobs) {
        $jobStatusIcon = "⏳"
        $jobStatusColor = "White"
        
        if ($job.conclusion -eq "success") {
            $jobStatusIcon = "✅"
            $jobStatusColor = "Green"
        } elseif ($job.conclusion -eq "failure") {
            $jobStatusIcon = "❌"
            $jobStatusColor = "Red"
        } elseif ($job.conclusion -eq "skipped") {
            $jobStatusIcon = "⏭️"
            $jobStatusColor = "Yellow"
        } elseif ($job.conclusion -eq "cancelled") {
            $jobStatusIcon = "⚠️"
            $jobStatusColor = "Yellow"
        }
        
        Write-Host "  $jobStatusIcon $($job.name)" -ForegroundColor $jobStatusColor
        Write-Host "     Status: $($job.status)" -ForegroundColor Gray
        if ($job.conclusion) {
            Write-Host "     Conclusion: $($job.conclusion)" -ForegroundColor Gray
        }
        Write-Host ""
    }
    
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To view full details in browser:" -ForegroundColor Yellow
    Write-Host "  gh run view $($latestRun.databaseId) --repo $repo --web" -ForegroundColor White
    Write-Host ""
    Write-Host "To view logs:" -ForegroundColor Yellow
    Write-Host "  gh run view $($latestRun.databaseId) --repo $repo --log" -ForegroundColor White
    Write-Host ""
    
}
catch {
    Write-Host "❌ Error fetching workflow runs: $_" -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "✅ Status check complete!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
