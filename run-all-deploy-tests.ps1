# Comprehensive Deployment Testing Script
Write-Host "=== COMPREHENSIVE DEPLOYMENT TESTING ===" -ForegroundColor Green
Write-Host ""

# 1. YAML Validation Tests
Write-Host "1. Testing YAML Configuration Files..." -ForegroundColor Yellow
$yamlFiles = @('provider.yaml', 'deployment.yaml', 'service.yaml', 'deploy-dashboard.yml', 'grafana-dashboard.yaml')
foreach ($file in $yamlFiles) {
    if (Test-Path $file) {
        try {
            $null = python -c "import yaml; yaml.safe_load(open('$file'))"
            Write-Host "  ✅ $file - Valid" -ForegroundColor Green
        } catch {
            Write-Host "  ❌ $file - Invalid: $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "  ⚠️  $file - Not found" -ForegroundColor Yellow
    }
}

Write-Host ""

# 2. Docker Build Test
Write-Host "2. Testing Docker Build..." -ForegroundColor Yellow
try {
    docker build -t owlbandocker/dashboard:test . 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Docker build successful" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Docker build failed" -ForegroundColor Red
    }
} catch {
    Write-Host "  ❌ Docker build error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# 3. Docker Run Test
Write-Host "3. Testing Docker Container..." -ForegroundColor Yellow
try {
    # Clean up any existing test container
    docker rm -f grafana-test 2>&1 | Out-Null

    # Run container
    docker run -d --name grafana-test -p 3000:3000 -e GF_SECURITY_ADMIN_PASSWORD=admin owlbandocker/dashboard:test 2>&1 | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Container started successfully" -ForegroundColor Green

        # Wait for Grafana to start
        Start-Sleep -Seconds 15

        # Test health endpoint
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:3000/api/health" -Method GET -TimeoutSec 10
            Write-Host "  ✅ Health check passed (Status: $($response.StatusCode))" -ForegroundColor Green
        } catch {
            Write-Host "  ❌ Health check failed: $($_.Exception.Message)" -ForegroundColor Red
        }

        # Test login endpoint
        try {
            $headers = @{
                "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("admin:admin"))
            }
            $response = Invoke-WebRequest -Uri "http://localhost:3000/api/user" -Method GET -Headers $headers -TimeoutSec 10
            Write-Host "  ✅ Authentication test passed" -ForegroundColor Green
        } catch {
            Write-Host "  ❌ Authentication test failed: $($_.Exception.Message)" -ForegroundColor Red
        }

    } else {
        Write-Host "  ❌ Container failed to start" -ForegroundColor Red
    }
} catch {
    Write-Host "  ❌ Container test error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # Clean up
    docker rm -f grafana-test 2>&1 | Out-Null
}

Write-Host ""

# 4. Kubernetes Manifest Validation
Write-Host "4. Testing Kubernetes Manifests..." -ForegroundColor Yellow
if (Get-Command kubectl -ErrorAction SilentlyContinue) {
    $k8sFiles = @('deployment.yaml', 'service.yaml')
    foreach ($file in $k8sFiles) {
        try {
            kubectl apply --dry-run=client -f $file 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✅ $file - Valid" -ForegroundColor Green
            } else {
                Write-Host "  ❌ $file - Invalid" -ForegroundColor Red
            }
        } catch {
            Write-Host "  ❌ $file - Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
} else {
    Write-Host "  ⚠️  kubectl not found - skipping Kubernetes validation" -ForegroundColor Yellow
}

Write-Host ""

# 5. Ansible Playbook Validation
Write-Host "5. Testing Ansible Playbook..." -ForegroundColor Yellow
if (Get-Command ansible-playbook -ErrorAction SilentlyContinue) {
    try {
        ansible-playbook --syntax-check deploy-dashboard.yml 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Ansible playbook syntax valid" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Ansible playbook syntax invalid" -ForegroundColor Red
        }
    } catch {
        Write-Host "  ❌ Ansible test error: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "  ⚠️  ansible-playbook not found - skipping Ansible validation" -ForegroundColor Yellow
}

Write-Host ""

# 6. Crossplane Configuration Validation
Write-Host "6. Testing Crossplane Configurations..." -ForegroundColor Yellow
$crossplaneFiles = @('provider.yaml', 'grafana-dashboard.yaml')
foreach ($file in $crossplaneFiles) {
    if (Test-Path $file) {
        try {
            $null = python -c "import yaml; yaml.safe_load(open('$file'))"
            Write-Host "  ✅ $file - Valid YAML" -ForegroundColor Green
        } catch {
            Write-Host "  ❌ $file - Invalid YAML" -ForegroundColor Red
        }
    } else {
        Write-Host "  ⚠️  $file - Not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "=== TESTING COMPLETE ===" -ForegroundColor Green
Write-Host "Review results above and fix any issues found." -ForegroundColor Cyan
