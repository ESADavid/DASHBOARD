# Thorough Testing Script for Fly.io and Render.com Configurations
# Tests all configuration files and validates deployment readiness

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fly.io & Render.com Configuration Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$testResults = @()
$passCount = 0
$failCount = 0

function Test-Item {
    param(
        [string]$TestName,
        [bool]$Condition,
        [string]$SuccessMessage,
        [string]$FailureMessage
    )
    
    if ($Condition) {
        Write-Host "✅ PASS: $TestName" -ForegroundColor Green
        Write-Host "   $SuccessMessage" -ForegroundColor Gray
        $script:passCount++
        $script:testResults += @{
            Test = $TestName
            Status = "PASS"
            Message = $SuccessMessage
        }
    } else {
        Write-Host "❌ FAIL: $TestName" -ForegroundColor Red
        Write-Host "   $FailureMessage" -ForegroundColor Yellow
        $script:failCount++
        $script:testResults += @{
            Test = $TestName
            Status = "FAIL"
            Message = $FailureMessage
        }
    }
    Write-Host ""
}

# Test 1: Verify fly.toml exists
Write-Host "Test 1: Checking fly.toml existence..." -ForegroundColor Yellow
$flyTomlExists = Test-Path "fly.toml"
Test-Item -TestName "fly.toml file exists" `
    -Condition $flyTomlExists `
    -SuccessMessage "fly.toml found in project root" `
    -FailureMessage "fly.toml not found in project root"

# Test 2: Verify render.yaml exists
Write-Host "Test 2: Checking render.yaml existence..." -ForegroundColor Yellow
$renderYamlExists = Test-Path "render.yaml"
Test-Item -TestName "render.yaml file exists" `
    -Condition $renderYamlExists `
    -SuccessMessage "render.yaml found in project root" `
    -FailureMessage "render.yaml not found in project root"

# Test 3: Verify Dockerfile exists
Write-Host "Test 3: Checking Dockerfile existence..." -ForegroundColor Yellow
$dockerfileExists = Test-Path "Dockerfile"
Test-Item -TestName "Dockerfile exists" `
    -Condition $dockerfileExists `
    -SuccessMessage "Dockerfile found in project root" `
    -FailureMessage "Dockerfile not found in project root"

# Test 4: Verify nginx.conf exists
Write-Host "Test 4: Checking nginx.conf existence..." -ForegroundColor Yellow
$nginxConfExists = Test-Path "nginx.conf"
Test-Item -TestName "nginx.conf exists" `
    -Condition $nginxConfExists `
    -SuccessMessage "nginx.conf found in project root" `
    -FailureMessage "nginx.conf not found in project root"

# Test 5: Validate fly.toml content
Write-Host "Test 5: Validating fly.toml configuration..." -ForegroundColor Yellow
if ($flyTomlExists) {
    $flyContent = Get-Content "fly.toml" -Raw
    
    # Check app name
    $hasCorrectAppName = $flyContent -match 'app\s*=\s*"banking-dashboard"'
    Test-Item -TestName "fly.toml has correct app name" `
        -Condition $hasCorrectAppName `
        -SuccessMessage "App name is 'banking-dashboard'" `
        -FailureMessage "App name is not 'banking-dashboard'"
    
    # Check internal port
    $hasCorrectPort = $flyContent -match 'internal_port\s*=\s*80'
    Test-Item -TestName "fly.toml has correct internal port" `
        -Condition $hasCorrectPort `
        -SuccessMessage "Internal port is 80 (nginx default)" `
        -FailureMessage "Internal port is not 80"
    
    # Check health check path
    $hasHealthCheck = $flyContent -match 'path\s*=\s*"/health"'
    Test-Item -TestName "fly.toml has correct health check path" `
        -Condition $hasHealthCheck `
        -SuccessMessage "Health check path is /health" `
        -FailureMessage "Health check path is not /health"
    
    # Check no Grafana variables
    $noGrafanaVars = -not ($flyContent -match 'GF_')
    Test-Item -TestName "fly.toml has no Grafana environment variables" `
        -Condition $noGrafanaVars `
        -SuccessMessage "No Grafana-specific variables found" `
        -FailureMessage "Grafana variables (GF_*) still present"
}

# Test 6: Validate render.yaml content
Write-Host "Test 6: Validating render.yaml configuration..." -ForegroundColor Yellow
if ($renderYamlExists) {
    $renderContent = Get-Content "render.yaml" -Raw
    
    # Check service name
    $hasCorrectServiceName = $renderContent -match 'name:\s*banking-dashboard'
    Test-Item -TestName "render.yaml has correct service name" `
        -Condition $hasCorrectServiceName `
        -SuccessMessage "Service name is 'banking-dashboard'" `
        -FailureMessage "Service name is not 'banking-dashboard'"
    
    # Check health check path
    $hasCorrectHealthPath = $renderContent -match 'healthCheckPath:\s*/health'
    Test-Item -TestName "render.yaml has correct health check path" `
        -Condition $hasCorrectHealthPath `
        -SuccessMessage "Health check path is /health" `
        -FailureMessage "Health check path is not /health"
    
    # Check no Grafana variables
    $noGrafanaEnvVars = -not ($renderContent -match 'GF_')
    Test-Item -TestName "render.yaml has no Grafana environment variables" `
        -Condition $noGrafanaEnvVars `
        -SuccessMessage "No Grafana-specific variables found" `
        -FailureMessage "Grafana variables (GF_*) still present"
    
    # Check runtime is docker
    $hasDockerRuntime = $renderContent -match 'runtime:\s*docker'
    Test-Item -TestName "render.yaml uses Docker runtime" `
        -Condition $hasDockerRuntime `
        -SuccessMessage "Runtime is set to 'docker'" `
        -FailureMessage "Runtime is not set to 'docker'"
}

# Test 7: Validate Dockerfile content
Write-Host "Test 7: Validating Dockerfile configuration..." -ForegroundColor Yellow
if ($dockerfileExists) {
    $dockerContent = Get-Content "Dockerfile" -Raw
    
    # Check nginx base image
    $hasNginxImage = $dockerContent -match 'FROM\s+nginx:alpine'
    Test-Item -TestName "Dockerfile uses nginx:alpine base image" `
        -Condition $hasNginxImage `
        -SuccessMessage "Base image is nginx:alpine" `
        -FailureMessage "Base image is not nginx:alpine"
    
    # Check port 80 exposure
    $exposesPort80 = $dockerContent -match 'EXPOSE\s+80'
    Test-Item -TestName "Dockerfile exposes port 80" `
        -Condition $exposesPort80 `
        -SuccessMessage "Port 80 is exposed" `
        -FailureMessage "Port 80 is not exposed"
    
    # Check health check
    $hasHealthCheck = $dockerContent -match 'HEALTHCHECK'
    Test-Item -TestName "Dockerfile has health check" `
        -Condition $hasHealthCheck `
        -SuccessMessage "Health check is configured" `
        -FailureMessage "Health check is not configured"
}

# Test 8: Validate nginx.conf content
Write-Host "Test 8: Validating nginx.conf configuration..." -ForegroundColor Yellow
if ($nginxConfExists) {
    $nginxContent = Get-Content "nginx.conf" -Raw
    
    # Check port 80 listener
    $listensOn80 = $nginxContent -match 'listen\s+80'
    Test-Item -TestName "nginx.conf listens on port 80" `
        -Condition $listensOn80 `
        -SuccessMessage "Nginx configured to listen on port 80" `
        -FailureMessage "Nginx not configured to listen on port 80"
    
    # Check health endpoint
    $hasHealthEndpoint = $nginxContent -match 'location\s+/health'
    Test-Item -TestName "nginx.conf has /health endpoint" `
        -Condition $hasHealthEndpoint `
        -SuccessMessage "/health endpoint is configured" `
        -FailureMessage "/health endpoint is not configured"
}

# Test 9: Verify deployment script exists
Write-Host "Test 9: Checking deployment script..." -ForegroundColor Yellow
$deployScriptExists = Test-Path "deploy-to-platforms.ps1"
Test-Item -TestName "deploy-to-platforms.ps1 exists" `
    -Condition $deployScriptExists `
    -SuccessMessage "Deployment script found" `
    -FailureMessage "Deployment script not found"

# Test 10: Validate deployment script content
Write-Host "Test 10: Validating deployment script configuration..." -ForegroundColor Yellow
if ($deployScriptExists) {
    $deployContent = Get-Content "deploy-to-platforms.ps1" -Raw
    
    # Check app name variable
    $hasCorrectAppVar = $deployContent -match '\$APP_NAME\s*=\s*"banking-dashboard"'
    Test-Item -TestName "Deployment script has correct app name" `
        -Condition $hasCorrectAppVar `
        -SuccessMessage "APP_NAME is 'banking-dashboard'" `
        -FailureMessage "APP_NAME is not 'banking-dashboard'"
    
    # Check region variable
    $hasCorrectRegion = $deployContent -match '\$FLY_REGION\s*=\s*"iad"'
    Test-Item -TestName "Deployment script has correct region" `
        -Condition $hasCorrectRegion `
        -SuccessMessage "FLY_REGION is 'iad' (matches fly.toml)" `
        -FailureMessage "FLY_REGION does not match fly.toml"
}

# Test 11: Verify documentation exists
Write-Host "Test 11: Checking documentation files..." -ForegroundColor Yellow
$setupGuideExists = Test-Path "RENDER_FLYIO_SETUP_GUIDE.md"
Test-Item -TestName "RENDER_FLYIO_SETUP_GUIDE.md exists" `
    -Condition $setupGuideExists `
    -SuccessMessage "Setup guide documentation found" `
    -FailureMessage "Setup guide documentation not found"

$completionDocExists = Test-Path "FLY_RENDER_DEPLOYMENT_COMPLETE.md"
Test-Item -TestName "FLY_RENDER_DEPLOYMENT_COMPLETE.md exists" `
    -Condition $completionDocExists `
    -SuccessMessage "Completion documentation found" `
    -FailureMessage "Completion documentation not found"

# Test 12: Verify TODO.md updated
Write-Host "Test 12: Checking TODO.md updates..." -ForegroundColor Yellow
$todoExists = Test-Path "TODO.md"
if ($todoExists) {
    $todoContent = Get-Content "TODO.md" -Raw
    
    $flyTomlFixed = $todoContent -match '\[x\].*Fix fly\.toml'
    Test-Item -TestName "TODO.md marks fly.toml as fixed" `
        -Condition $flyTomlFixed `
        -SuccessMessage "fly.toml fix is marked complete in TODO.md" `
        -FailureMessage "fly.toml fix is not marked complete in TODO.md"
    
    $renderYamlFixed = $todoContent -match '\[x\].*Fix render\.yaml'
    Test-Item -TestName "TODO.md marks render.yaml as fixed" `
        -Condition $renderYamlFixed `
        -SuccessMessage "render.yaml fix is marked complete in TODO.md" `
        -FailureMessage "render.yaml fix is not marked complete in TODO.md"
}

# Test 13: Port consistency check
Write-Host "Test 13: Verifying port consistency across all configs..." -ForegroundColor Yellow
$allUsePort80 = $flyTomlExists -and $dockerfileExists -and $nginxConfExists -and `
                ($flyContent -match 'internal_port\s*=\s*80') -and `
                ($dockerContent -match 'EXPOSE\s+80') -and `
                ($nginxContent -match 'listen\s+80')
Test-Item -TestName "All configurations use port 80 consistently" `
    -Condition $allUsePort80 `
    -SuccessMessage "Port 80 is consistent across fly.toml, Dockerfile, and nginx.conf" `
    -FailureMessage "Port configuration is inconsistent across files"

# Test 14: Health check consistency
Write-Host "Test 14: Verifying health check consistency..." -ForegroundColor Yellow
$allUseHealthPath = $flyTomlExists -and $renderYamlExists -and $nginxConfExists -and `
                    ($flyContent -match 'path\s*=\s*"/health"') -and `
                    ($renderContent -match 'healthCheckPath:\s*/health') -and `
                    ($nginxContent -match 'location\s+/health')
Test-Item -TestName "Health check path /health is consistent" `
    -Condition $allUseHealthPath `
    -SuccessMessage "/health endpoint is consistent across all configurations" `
    -FailureMessage "Health check path is inconsistent across configurations"

# Test 15: Check for public directory
Write-Host "Test 15: Verifying static content directory..." -ForegroundColor Yellow
$publicDirExists = Test-Path "public"
Test-Item -TestName "public directory exists" `
    -Condition $publicDirExists `
    -SuccessMessage "public directory found (contains static files)" `
    -FailureMessage "public directory not found"

if ($publicDirExists) {
    $indexExists = Test-Path "public/index.html"
    Test-Item -TestName "public/index.html exists" `
        -Condition $indexExists `
        -SuccessMessage "Main HTML file found" `
        -FailureMessage "Main HTML file not found"
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Tests: $($passCount + $failCount)" -ForegroundColor White
Write-Host "Passed: $passCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($failCount -eq 0) {
    Write-Host "✅ ALL TESTS PASSED!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Configuration Status: READY FOR DEPLOYMENT" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Deploy to Fly.io: Run .\deploy-to-platforms.ps1 and select option 1" -ForegroundColor White
    Write-Host "2. Deploy to Render.com: Run .\deploy-to-platforms.ps1 and select option 2" -ForegroundColor White
    Write-Host "3. Or deploy to both: Run .\deploy-to-platforms.ps1 and select option 3" -ForegroundColor White
} else {
    Write-Host "⚠️  SOME TESTS FAILED" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please review the failed tests above and fix the issues before deploying." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Detailed Results:" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan
foreach ($result in $testResults) {
    $statusColor = if ($result.Status -eq "PASS") { "Green" } else { "Red" }
    Write-Host "$($result.Status): $($result.Test)" -ForegroundColor $statusColor
    Write-Host "   $($result.Message)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "Test completed at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host ""

# Return exit code based on test results
exit $failCount
