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
