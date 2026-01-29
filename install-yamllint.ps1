# Install yamllint on Windows using pip
Write-Host "Installing yamllint using pip..." -ForegroundColor Green

try {
    # Install yamllint
    & python -m pip install yamllint

    # Verify installation
    & yamllint --version
    Write-Host "yamllint installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to install yamllint: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Make sure Python and pip are installed and available in PATH." -ForegroundColor Yellow
}
