# Master Test Suite - Run All Automated Tests
# This script executes all available automated tests for the Plaid integration

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     PLAID INTEGRATION - MASTER TEST SUITE                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$totalTests = 0
$totalPassed = 0
$totalFailed = 0
$startTime = Get-Date

# Test Suite 1: Infrastructure & Container Health
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "TEST SUITE 1: Infrastructure and Container Health" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Checking Docker containers..." -ForegroundColor White
$containers = docker compose -f quickstart/docker-compose.yml ps --format json | ConvertFrom-Json
$runningContainers = ($containers | Where-Object {$_.State -eq "running"}).Count

if ($runningContainers -ge 2) {
    Write-Host "✓ Containers Running: $runningContainers/2" -ForegroundColor Green
    $totalPassed += 1
} else {
    Write-Host "✗ Containers Running: $runningContainers/2" -ForegroundColor Red
    $totalFailed += 1
}
$totalTests += 1

Write-Host ""

# Test Suite 2: Plaid API Direct Connection
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "TEST SUITE 2: Plaid API Direct Connection" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Running: test-plaid-direct.ps1" -ForegroundColor White
try {
    $output = & .\test-plaid-direct.ps1 2>&1
    if ($output -match "Success") {
        Write-Host "✓ Plaid API Connection Test: PASSED" -ForegroundColor Green
        $totalPassed += 1
    } else {
        Write-Host "✗ Plaid API Connection Test: FAILED" -ForegroundColor Red
        $totalFailed += 1
    }
} catch {
    Write-Host "✗ Plaid API Connection Test: ERROR" -ForegroundColor Red
    $totalFailed += 1
}
$totalTests += 1

Write-Host ""

# Test Suite 3: Backend API Endpoints
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "TEST SUITE 3: Backend API Endpoints - 9 endpoints" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Running: test-all-endpoints.ps1" -ForegroundColor White
try {
    $output = & .\test-all-endpoints.ps1 2>&1 | Out-String
    if ($output -match "Passed: 9") {
        Write-Host "✓ All API Endpoints Test: PASSED (9/9)" -ForegroundColor Green
        $totalPassed += 9
    } else {
        Write-Host "✗ API Endpoints Test: Some failures detected" -ForegroundColor Red
        # Try to extract pass/fail counts
        if ($output -match "Passed: (\d+)") {
            $passed = [int]$matches[1]
            $totalPassed += $passed
            $totalFailed += (9 - $passed)
        } else {
            $totalFailed += 9
        }
    }
} catch {
    Write-Host "✗ API Endpoints Test: ERROR" -ForegroundColor Red
    $totalFailed += 9
}
$totalTests += 9

Write-Host ""

# Test Suite 4: Frontend Health Check
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "TEST SUITE 4: Frontend Health Check (7 tests)" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Running: test-frontend-health.ps1" -ForegroundColor White
try {
    $output = & .\test-frontend-health.ps1 2>&1 | Out-String
    if ($output -match "Passed: 7") {
        Write-Host "✓ Frontend Health Tests: PASSED (7/7)" -ForegroundColor Green
        $totalPassed += 7
    } else {
        Write-Host "✗ Frontend Health Tests: Some failures detected" -ForegroundColor Red
        if ($output -match "Passed: (\d+)") {
            $passed = [int]$matches[1]
            $totalPassed += $passed
            $totalFailed += (7 - $passed)
        } else {
            $totalFailed += 7
        }
    }
} catch {
    Write-Host "✗ Frontend Health Tests: ERROR" -ForegroundColor Red
    $totalFailed += 7
}
$totalTests += 7

Write-Host ""

# Calculate results
$endTime = Get-Date
$duration = ($endTime - $startTime).TotalSeconds

# Final Summary
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    FINAL TEST SUMMARY                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "Total Tests Executed: $totalTests" -ForegroundColor White
Write-Host "Tests Passed: $totalPassed" -ForegroundColor Green
Write-Host "Tests Failed: $totalFailed" -ForegroundColor $(if ($totalFailed -eq 0) {"Green"} else {"Red"})
Write-Host "Success Rate: $([math]::Round(($totalPassed/$totalTests)*100, 2))%" -ForegroundColor $(if ($totalFailed -eq 0) {"Green"} else {"Yellow"})
Write-Host "Duration: $([math]::Round($duration, 2)) seconds" -ForegroundColor White

Write-Host ""

if ($totalFailed -eq 0) {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  ✓✓✓  ALL AUTOMATED TESTS PASSED SUCCESSFULLY!  ✓✓✓       ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "System Status: READY FOR MANUAL TESTING" -ForegroundColor Green
    Write-Host "Next Step: Open http://localhost:3000 for manual integration testing" -ForegroundColor Cyan
} else {
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "║  ✗✗✗  SOME TESTS FAILED - REVIEW REQUIRED  ✗✗✗            ║" -ForegroundColor Red
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please review the test output above for details." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Test Reports Available:" -ForegroundColor Cyan
Write-Host "  - PLAID_INTEGRATION_TEST_RESULTS.md" -ForegroundColor White
Write-Host "  - THOROUGH_TESTING_COMPLETE.md" -ForegroundColor White
Write-Host "  - MANUAL_INTEGRATION_TEST_GUIDE.md" -ForegroundColor White
Write-Host ""
