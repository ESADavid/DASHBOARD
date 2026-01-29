# Deploy Grafana Dashboard using Docker
Write-Host "Deploying Grafana Dashboard with Docker..." -ForegroundColor Green

# Build the Docker image
Write-Host "Building Docker image..." -ForegroundColor Yellow
docker build -t owlbandocker/dashboard:latest .

# Run the container
Write-Host "Starting Grafana container..." -ForegroundColor Yellow
docker run -d --name grafana-dashboard -p 3000:3000 `
  -e GF_SECURITY_ADMIN_PASSWORD=admin `
  -e GF_USERS_ALLOW_SIGN_UP=false `
  owlbandocker/dashboard:latest

# Wait for container to start
Start-Sleep -Seconds 10

# Test the deployment
Write-Host "Testing deployment..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/api/health" -Method GET
    Write-Host "Grafana is running! Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Access Grafana at: http://localhost:3000" -ForegroundColor Cyan
    Write-Host "Username: admin" -ForegroundColor Cyan
    Write-Host "Password: admin" -ForegroundColor Cyan
} catch {
    Write-Host "Deployment test failed: $($_.Exception.Message)" -ForegroundColor Red
}
