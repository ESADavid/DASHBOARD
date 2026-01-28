# Verify Python Import Fix
# This script tests that the Plaid Python SDK is properly installed

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Python Import Verification Test" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Check if plaid module can be imported
Write-Host "Test 1: Verifying plaid module import..." -ForegroundColor Yellow
$importTest = python -c "import plaid; print('SUCCESS: plaid module imported'); print(f'Version: {plaid.__version__}')" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ PASSED: Plaid module imported successfully" -ForegroundColor Green
    Write-Host $importTest -ForegroundColor Gray
} else {
    Write-Host "❌ FAILED: Could not import plaid module" -ForegroundColor Red
    Write-Host $importTest -ForegroundColor Red
    exit 1
}

Write-Host ""

# Test 2: Check if all required packages are installed
Write-Host "Test 2: Verifying all required packages..." -ForegroundColor Yellow
$packages = @("Flask", "plaid-python", "python-dotenv", "itsdangerous", "werkzeug")
$allInstalled = $true

foreach ($package in $packages) {
    $checkPackage = python -m pip show $package 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ $package is installed" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $package is NOT installed" -ForegroundColor Red
        $allInstalled = $false
    }
}

if (-not $allInstalled) {
    Write-Host ""
    Write-Host "❌ Some packages are missing!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Test 3: Test specific plaid imports used in server.py
Write-Host "Test 3: Testing specific Plaid SDK imports..." -ForegroundColor Yellow
$specificImports = "from plaid.model.payment_amount import PaymentAmount; from plaid.model.products import Products; from plaid.model.country_code import CountryCode; from plaid.api import plaid_api; print('SUCCESS: All specific imports work')"

$specificTest = python -c $specificImports 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ PASSED: All specific Plaid imports successful" -ForegroundColor Green
} else {
    Write-Host "❌ FAILED: Some Plaid imports failed" -ForegroundColor Red
    Write-Host $specificTest -ForegroundColor Red
    exit 1
}

Write-Host ""

# Test 4: Quick syntax check of server.py
Write-Host "Test 4: Checking server.py syntax..." -ForegroundColor Yellow
$syntaxCheck = python -m py_compile quickstart/python/server.py 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ PASSED: server.py has no syntax errors" -ForegroundColor Green
} else {
    Write-Host "❌ FAILED: server.py has syntax errors" -ForegroundColor Red
    Write-Host $syntaxCheck -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ ALL TESTS PASSED!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "The Python import errors have been resolved." -ForegroundColor Green
Write-Host "You can now:" -ForegroundColor White
Write-Host "  1. Restart VSCode or reload the Python language server" -ForegroundColor White
Write-Host "  2. The linter errors should disappear" -ForegroundColor White
Write-Host "  3. Run the Python server with: cd quickstart/python && python server.py" -ForegroundColor White
Write-Host ""
