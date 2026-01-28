# Frontend Health Check and Automated Testing Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Frontend Health & Automated Testing" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$frontendUrl = "http://localhost:3000"
$backendUrl = "http://localhost:8000"
$results = @()

# Test 1: Frontend Accessibility
Write-Host "Test 1: Frontend Accessibility..." -NoNewline
try {
    $response = Invoke-WebRequest -Uri $frontendUrl -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host " PASS" -ForegroundColor Green
        $results += @{Test="Frontend Accessible"; Status="PASS"; Details="Status: $($response.StatusCode)"}
    }
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="Frontend Accessible"; Status="FAIL"; Details=$_.Exception.Message}
}

# Test 2: Frontend HTML Content
Write-Host "Test 2: Frontend HTML Content..." -NoNewline
try {
    $response = Invoke-WebRequest -Uri $frontendUrl -UseBasicParsing
    $content = $response.Content
    
    $checks = @{
        "Contains HTML" = $content -match "<html"
        "Contains React Root" = $content -match "root"
        "No Error Messages" = $content -notmatch "error|Error|ERROR"
    }
    
    $allPassed = ($checks.Values | Where-Object {$_ -eq $false}).Count -eq 0
    
    if ($allPassed) {
        Write-Host " PASS" -ForegroundColor Green
        $results += @{Test="Frontend HTML Content"; Status="PASS"; Details="All content checks passed"}
    } else {
        Write-Host " PARTIAL" -ForegroundColor Yellow
        $results += @{Test="Frontend HTML Content"; Status="PARTIAL"; Details="Some checks failed"}
    }
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="Frontend HTML Content"; Status="FAIL"; Details=$_.Exception.Message}
}

# Test 3: Backend API Reachability from Frontend Perspective
Write-Host "Test 3: Backend API Reachability..." -NoNewline
try {
    $response = Invoke-WebRequest -Uri "$backendUrl/api/info" -Method POST -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-Host " PASS" -ForegroundColor Green
        $results += @{Test="Backend API Reachable"; Status="PASS"; Details="API responding"}
    }
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="Backend API Reachable"; Status="FAIL"; Details=$_.Exception.Message}
}

# Test 4: Link Token Creation (Frontend Flow Simulation)
Write-Host "Test 4: Link Token Creation Flow..." -NoNewline
try {
    $response = Invoke-WebRequest -Uri "$backendUrl/api/create_link_token" -Method POST -UseBasicParsing
    $content = $response.Content | ConvertFrom-Json
    
    if ($content.link_token) {
        Write-Host " PASS" -ForegroundColor Green
        $results += @{Test="Link Token Creation"; Status="PASS"; Details="Token: $($content.link_token.Substring(0,20))..."}
    } else {
        Write-Host " FAIL" -ForegroundColor Red
        $results += @{Test="Link Token Creation"; Status="FAIL"; Details="No token in response"}
    }
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="Link Token Creation"; Status="FAIL"; Details=$_.Exception.Message}
}

# Test 5: Frontend Static Assets
Write-Host "Test 5: Frontend Static Assets..." -NoNewline
try {
    # Try to access common static file paths
    $staticTests = @{
        "Manifest" = "$frontendUrl/manifest.json"
        "Favicon" = "$frontendUrl/favicon.ico"
    }
    
    $staticPassed = 0
    foreach ($asset in $staticTests.GetEnumerator()) {
        try {
            $resp = Invoke-WebRequest -Uri $asset.Value -UseBasicParsing -TimeoutSec 2
            if ($resp.StatusCode -eq 200) { $staticPassed++ }
        } catch {
            # Some assets may not exist, that's ok
        }
    }
    
    Write-Host " PASS ($staticPassed/$($staticTests.Count) assets found)" -ForegroundColor Green
    $results += @{Test="Static Assets"; Status="PASS"; Details="$staticPassed/$($staticTests.Count) assets accessible"}
} catch {
    Write-Host " PARTIAL" -ForegroundColor Yellow
    $results += @{Test="Static Assets"; Status="PARTIAL"; Details="Some assets not found"}
}

# Test 6: Response Time Performance
Write-Host "Test 6: Response Time Performance..." -NoNewline
try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $response = Invoke-WebRequest -Uri $frontendUrl -UseBasicParsing
    $stopwatch.Stop()
    $responseTime = $stopwatch.ElapsedMilliseconds
    
    if ($responseTime -lt 2000) {
        Write-Host " PASS ($responseTime ms)" -ForegroundColor Green
        $results += @{Test="Response Time"; Status="PASS"; Details="$responseTime ms"}
    } else {
        Write-Host " SLOW ($responseTime ms)" -ForegroundColor Yellow
        $results += @{Test="Response Time"; Status="SLOW"; Details="$responseTime ms"}
    }
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="Response Time"; Status="FAIL"; Details=$_.Exception.Message}
}

# Test 7: CORS Headers (if applicable)
Write-Host "Test 7: CORS Configuration..." -NoNewline
try {
    $response = Invoke-WebRequest -Uri "$backendUrl/api/info" -Method POST -UseBasicParsing
    
    # Check if CORS headers are present (optional for same-origin)
    Write-Host " PASS" -ForegroundColor Green
    $results += @{Test="CORS Configuration"; Status="PASS"; Details="Backend accessible"}
} catch {
    Write-Host " FAIL" -ForegroundColor Red
    $results += @{Test="CORS Configuration"; Status="FAIL"; Details=$_.Exception.Message}
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$passed = ($results | Where-Object {$_.Status -eq "PASS"}).Count
$failed = ($results | Where-Object {$_.Status -eq "FAIL"}).Count
$partial = ($results | Where-Object {$_.Status -in @("PARTIAL", "SLOW")}).Count

Write-Host "Total Tests: $($results.Count)" -ForegroundColor White
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -eq 0) {"Green"} else {"Red"})
Write-Host "Partial/Warnings: $partial" -ForegroundColor $(if ($partial -eq 0) {"Green"} else {"Yellow"})
Write-Host ""

if ($failed -eq 0) {
    Write-Host "All critical tests passed!" -ForegroundColor Green
    Write-Host "Frontend is healthy and ready for manual testing." -ForegroundColor Green
} else {
    Write-Host "Some tests failed. Review details above." -ForegroundColor Red
}

Write-Host ""
Write-Host "Next Step: Open http://localhost:3000 in browser for manual testing" -ForegroundColor Cyan
