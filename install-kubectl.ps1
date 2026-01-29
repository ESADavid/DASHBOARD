# Install kubectl on Windows
Write-Host "Installing kubectl for Windows..." -ForegroundColor Green

# Download kubectl
$url = "https://dl.k8s.io/release/v1.28.0/bin/windows/amd64/kubectl.exe"
$output = "$PSScriptRoot\kubectl.exe"

try {
    Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
    Write-Host "kubectl downloaded successfully!" -ForegroundColor Green

    # Add to PATH for current session
    $env:PATH += ";$PSScriptRoot"

    # Verify installation
    & "$PSScriptRoot\kubectl.exe" version --client
    Write-Host "kubectl installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download kubectl: $($_.Exception.Message)" -ForegroundColor Red
}
