# Plaid Payroll Endpoints Test Script
# This script tests the newly implemented payroll and employment endpoints

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Plaid Payroll Integration Test Suite" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$baseUrl = "http://localhost:8000"
$testResults = @{
    Passed = 0
    Failed = 0
    Tests = @()
}

# Helper function to test endpoint
function Test-Endpoint {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Method = "GET"
    )
    
    Write-Host "Testing: $Name" -ForegroundColor Yellow
    Write-Host "URL: $Url" -ForegroundColor Gray
    
    try {
        $response = Invoke-RestMethod -Uri $Url -Method $Method -ErrorAction Stop
        
        if ($response.error -eq $null -or $response.error -eq "") {
            Write-Host "PASSED" -ForegroundColor Green
            $testResults.Passed++
            $testResults.Tests += @{
                Name = $Name
                Status = "PASSED"
                Response = $response
            }
            
            # Display response summary
            if ($response.payroll) {
                Write-Host "  - Payroll data retrieved successfully" -ForegroundColor Green
                if ($response.payroll.employments) {
                    Write-Host "  - Employments found: $($response.payroll.employments.Count)" -ForegroundColor Green
                }
            }
            if ($response.employment) {
                Write-Host "  - Employment data retrieved successfully" -ForegroundColor Green
                if ($response.employment.employments) {
                    Write-Host "  - Employments found: $($response.employment.employments.Count)" -ForegroundColor Green
                }
            }
        } else {
            Write-Host "FAILED - Error in response" -ForegroundColor Red
            Write-Host "  Error: $($response.error)" -ForegroundColor Red
            $testResults.Failed++
            $testResults.Tests += @{
                Name = $Name
                Status = "FAILED"
                Error = $response.error
            }
        }
    }
    catch {
        Write-Host "FAILED - Exception occurred" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $testResults.Failed++
        $testResults.Tests += @{
            Name = $Name
            Status = "FAILED"
            Error = $_.Exception.Message
        }
    }
    
    Write-Host ""
}

# Check if server is running
Write-Host "Checking if server is running..." -ForegroundColor Cyan
try {
    $healthCheck = Invoke-RestMethod -Uri "$baseUrl/api/info" -Method POST -ErrorAction Stop
    Write-Host "Server is running" -ForegroundColor Green
    Write-Host "  Products: $($healthCheck.products -join ', ')" -ForegroundColor Gray
    Write-Host ""
}
catch {
    Write-Host "Server is not running at $baseUrl" -ForegroundColor Red
    Write-Host "  Please start the server first:" -ForegroundColor Yellow
    Write-Host "  cd quickstart/node && npm start" -ForegroundColor Yellow
    Write-Host "  OR" -ForegroundColor Yellow
    Write-Host "  cd quickstart/python && python server.py" -ForegroundColor Yellow
    exit 1
}

# Run Tests
Write-Host "Running Payroll Integration Tests..." -ForegroundColor Cyan
Write-Host ""

# Test 1: Payroll Endpoint
Test-Endpoint -Name "Payroll Data Retrieval" -Url "$baseUrl/api/payroll"

# Test 2: Employment Endpoint
Test-Endpoint -Name "Employment Verification" -Url "$baseUrl/api/employment"

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Tests: $($testResults.Passed + $testResults.Failed)" -ForegroundColor White
Write-Host "Passed: $($testResults.Passed)" -ForegroundColor Green
Write-Host "Failed: $($testResults.Failed)" -ForegroundColor Red
Write-Host ""

# Detailed Results
if ($testResults.Failed -gt 0) {
    Write-Host "Failed Tests:" -ForegroundColor Red
    foreach ($test in $testResults.Tests | Where-Object { $_.Status -eq "FAILED" }) {
        Write-Host "  - $($test.Name)" -ForegroundColor Red
        Write-Host "    Error: $($test.Error)" -ForegroundColor Gray
    }
    Write-Host ""
}

# Save results to file
$resultsFile = "payroll-test-results.json"
$testResults | ConvertTo-Json -Depth 10 | Out-File $resultsFile
Write-Host "Results saved to: $resultsFile" -ForegroundColor Cyan

# Exit with appropriate code
if ($testResults.Failed -gt 0) {
    Write-Host "Some tests failed. Please review the errors above." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "All tests passed successfully!" -ForegroundColor Green
    exit 0
}
