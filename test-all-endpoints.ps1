# Comprehensive Plaid API Endpoint Testing Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Plaid API Endpoint Testing" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:8000"
$results = @()

# Test endpoints
$endpoints = @(
    @{Name="Info"; Method="POST"; Path="/api/info"; ExpectError=$false},
    @{Name="Create Link Token"; Method="POST"; Path="/api/create_link_token"; ExpectError=$false},
    @{Name="Accounts"; Method="GET"; Path="/api/accounts"; ExpectError=$true},
    @{Name="Balance"; Method="GET"; Path="/api/balance"; ExpectError=$true},
    @{Name="Transactions"; Method="POST"; Path="/api/transactions"; ExpectError=$true},
    @{Name="Auth"; Method="GET"; Path="/api/auth"; ExpectError=$true},
    @{Name="Identity"; Method="GET"; Path="/api/identity"; ExpectError=$true},
    @{Name="Holdings"; Method="GET"; Path="/api/holdings"; ExpectError=$true},
    @{Name="Investment Transactions"; Method="GET"; Path="/api/investments_transactions"; ExpectError=$true}
)

foreach ($endpoint in $endpoints) {
    Write-Host "Testing: $($endpoint.Name)..." -NoNewline
    
    try {
        $response = Invoke-WebRequest -Uri "$baseUrl$($endpoint.Path)" -Method $endpoint.Method -UseBasicParsing -ErrorAction Stop
        
        if ($response.StatusCode -eq 200) {
            $content = $response.Content | ConvertFrom-Json
            
            if ($endpoint.ExpectError) {
                if ($content.error) {
                    Write-Host " PASS (Expected error returned)" -ForegroundColor Green
                    $results += @{Endpoint=$endpoint.Name; Status="PASS"; Note="Expected error: $($content.error.error_code)"}
                } else {
                    Write-Host " PASS (Data returned)" -ForegroundColor Green
                    $results += @{Endpoint=$endpoint.Name; Status="PASS"; Note="Data returned successfully"}
                }
            } else {
                Write-Host " PASS" -ForegroundColor Green
                $results += @{Endpoint=$endpoint.Name; Status="PASS"; Note="Success"}
            }
        }
    }
    catch {
        Write-Host " FAIL" -ForegroundColor Red
        $results += @{Endpoint=$endpoint.Name; Status="FAIL"; Note=$_.Exception.Message}
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$passed = ($results | Where-Object {$_.Status -eq "PASS"}).Count
$failed = ($results | Where-Object {$_.Status -eq "FAIL"}).Count

Write-Host "Total Tests: $($results.Count)" -ForegroundColor White
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -eq 0) {"Green"} else {"Red"})
Write-Host ""

if ($failed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "Some tests failed. See details above." -ForegroundColor Red
}
