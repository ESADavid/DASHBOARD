# Complete Automated Test Suite for Plaid Integration
Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  PLAID INTEGRATION - COMPLETE TEST SUITE" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""

$startTime = Get-Date

# Test 1: Container Health
Write-Host "[1/4] Testing Container Health..." -ForegroundColor Yellow
docker compose -f quickstart/docker-compose.yml ps
Write-Host ""

# Test 2: Plaid API Direct Connection  
Write-Host "[2/4] Testing Plaid API Connection..." -ForegroundColor Yellow
.\test-plaid-direct.ps1
Write-Host ""

# Test 3: Backend API Endpoints
Write-Host "[3/4] Testing Backend API Endpoints..." -ForegroundColor Yellow
.\test-all-endpoints.ps1
Write-Host ""

# Test 4: Frontend Health
Write-Host "[4/4] Testing Frontend Health..." -ForegroundColor Yellow
.\test-frontend-health.ps1
Write-Host ""

$endTime = Get-Date
$duration = ($endTime - $startTime).TotalSeconds

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  TEST SUITE COMPLETE" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "Duration: $([math]::Round($duration, 2)) seconds" -ForegroundColor White
Write-Host ""
Write-Host "All automated tests have been executed." -ForegroundColor Green
Write-Host "Review the output above for detailed results." -ForegroundColor White
Write-Host ""
Write-Host "Next Step: Manual testing at http://localhost:3000" -ForegroundColor Cyan
Write-Host "Guide: MANUAL_INTEGRATION_TEST_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
