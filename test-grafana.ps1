# Test Grafana API endpoints
Write-Host "Testing Grafana API endpoints..." -ForegroundColor Green

$baseUrl = "http://localhost:3000"
$credentials = "admin:admin"

# Test health endpoint
Write-Host "Testing health endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/health" -Method GET
    Write-Host "Health check: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "Health check failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test org endpoint
Write-Host "Testing org endpoint..." -ForegroundColor Yellow
try {
    $headers = @{
        "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))
    }
    $response = Invoke-WebRequest -Uri "$baseUrl/api/org" -Method GET -Headers $headers
    Write-Host "Org endpoint: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Org endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test datasources endpoint
Write-Host "Testing datasources endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/datasources" -Method GET -Headers $headers
    Write-Host "Datasources endpoint: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "Datasources endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test dashboard endpoint
Write-Host "Testing dashboard endpoint..." -ForegroundColor Yellow
try {
    $bearerToken = "eyJrIjoiT0tTcG1pUlY2RnVKZTFVaDFsNFZXdE9ZWmNrMkZYbk"
    $dashboardHeaders = @{
        "Authorization" = "Bearer $bearerToken"
        "Accept" = "application/json"
    }
    $response = Invoke-WebRequest -Uri "$baseUrl/api/dashboards/db/mydash" -Method GET -Headers $dashboardHeaders
    Write-Host "Dashboard endpoint: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Dashboard endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
}
