# Fix Python Import Errors - Reinstall Compatible Plaid SDK
# This script downgrades plaid-python from v38.0.0 to v14.0.0 to fix import errors

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Python Import Error Fix Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to Python quickstart directory
$pythonDir = "quickstart/python"
if (-not (Test-Path $pythonDir)) {
    Write-Host "ERROR: Directory $pythonDir not found!" -ForegroundColor Red
    exit 1
}

Set-Location $pythonDir
Write-Host "Working directory: $(Get-Location)" -ForegroundColor Green
Write-Host ""

# Check if Python is installed
Write-Host "Step 1: Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python not found! Please install Python 3.8 or higher." -ForegroundColor Red
    exit 1
}
Write-Host ""

# Check if virtual environment exists
Write-Host "Step 2: Checking virtual environment..." -ForegroundColor Yellow
if (Test-Path "venv") {
    Write-Host "✓ Virtual environment found" -ForegroundColor Green
    $recreateVenv = Read-Host "Do you want to recreate the virtual environment? (y/n)"
    if ($recreateVenv -eq 'y') {
        Write-Host "Removing old virtual environment..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force venv
        Write-Host "Creating new virtual environment..." -ForegroundColor Yellow
        python -m venv venv
        Write-Host "✓ Virtual environment recreated" -ForegroundColor Green
    }
} else {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
    Write-Host "✓ Virtual environment created" -ForegroundColor Green
}
Write-Host ""

# Activate virtual environment
Write-Host "Step 3: Activating virtual environment..." -ForegroundColor Yellow
$activateScript = "venv\Scripts\Activate.ps1"
if (Test-Path $activateScript) {
    & $activateScript
    Write-Host "✓ Virtual environment activated" -ForegroundColor Green
} else {
    Write-Host "✗ Activation script not found!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Upgrade pip
Write-Host "Step 4: Upgrading pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip --quiet
Write-Host "✓ pip upgraded" -ForegroundColor Green
Write-Host ""

# Uninstall old plaid package
Write-Host "Step 5: Uninstalling old plaid-python package..." -ForegroundColor Yellow
pip uninstall -y plaid-python 2>$null
Write-Host "✓ Old package uninstalled" -ForegroundColor Green
Write-Host ""

# Install dependencies from requirements.txt
Write-Host "Step 6: Installing dependencies from requirements.txt..." -ForegroundColor Yellow
Write-Host "This will install plaid-python==14.0.0 (compatible version)" -ForegroundColor Cyan
pip install -r requirements.txt
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Verify plaid-python installation
Write-Host "Step 7: Verifying plaid-python installation..." -ForegroundColor Yellow
$plaidVersion = python -c "import plaid; print(plaid.__version__)" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ plaid-python version: $plaidVersion" -ForegroundColor Green
    
    if ($plaidVersion -like "14.*") {
        Write-Host "✓ Correct version installed (v14.x)" -ForegroundColor Green
    } else {
        Write-Host "⚠ Warning: Expected v14.x but got $plaidVersion" -ForegroundColor Yellow
    }
} else {
    Write-Host "✗ Failed to import plaid module" -ForegroundColor Red
    Write-Host "Error: $plaidVersion" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Test imports
Write-Host "Step 8: Testing critical imports..." -ForegroundColor Yellow
$testScript = @"
try:
    from plaid.model.payment_amount import PaymentAmount
    from plaid.model.products import Products
    from plaid.model.country_code import CountryCode
    from plaid.api import plaid_api
    print('SUCCESS: All imports working correctly')
except ImportError as e:
    print(f'ERROR: Import failed - {e}')
    exit(1)
"@

$testResult = python -c $testScript 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ $testResult" -ForegroundColor Green
} else {
    Write-Host "✗ Import test failed" -ForegroundColor Red
    Write-Host "Error: $testResult" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Check if .env file exists
Write-Host "Step 9: Checking environment configuration..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "✓ .env file found" -ForegroundColor Green
} else {
    Write-Host "⚠ Warning: .env file not found" -ForegroundColor Yellow
    Write-Host "  You'll need to create .env with your Plaid credentials" -ForegroundColor Yellow
}
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fix Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary of changes:" -ForegroundColor Cyan
Write-Host "  • Downgraded plaid-python from v38.0.0 to v14.0.0" -ForegroundColor White
Write-Host "  • All import errors should now be resolved" -ForegroundColor White
Write-Host "  • Virtual environment is activated and ready" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Restart your IDE/editor to clear cached errors" -ForegroundColor White
Write-Host "  2. Test the server: python server.py" -ForegroundColor White
Write-Host "  3. Verify endpoints are working" -ForegroundColor White
Write-Host ""
Write-Host "To start the server:" -ForegroundColor Yellow
Write-Host "  python server.py" -ForegroundColor White
Write-Host ""
Write-Host "To deactivate virtual environment:" -ForegroundColor Yellow
Write-Host "  deactivate" -ForegroundColor White
Write-Host ""

# Return to original directory
Set-Location ../..
