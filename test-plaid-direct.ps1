# Test Plaid API directly with credentials

$clientId = "64f0ceb0c03e65001990f108"
$secret = "a2ac2250b1840610ab174955f55912"
$uniqueUserId = "user-" + (Get-Date -Format "yyyyMMddHHmmss")

$body = @{
    client_id = $clientId
    secret = $secret
    client_name = "Plaid Test App"
    user = @{
        client_user_id = $uniqueUserId
    }
    products = @("auth")
    country_codes = @("US")
    language = "en"
} | ConvertTo-Json

Write-Host "Testing Plaid API directly..." -ForegroundColor Cyan
Write-Host "Client ID: $clientId" -ForegroundColor Yellow
Write-Host "User ID: $uniqueUserId" -ForegroundColor Yellow
Write-Host ""

try {
    $response = Invoke-RestMethod -Uri "https://sandbox.plaid.com/link/token/create" -Method POST -ContentType "application/json" -Body $body
    
    Write-Host "Success! Link token created:" -ForegroundColor Green
    Write-Host ""
    $response | ConvertTo-Json -Depth 10
    Write-Host ""
    Write-Host "Link Token: $($response.link_token)" -ForegroundColor Green
    Write-Host "Expiration: $($response.expiration)" -ForegroundColor Yellow
    
} catch {
    Write-Host "Error occurred:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    if ($_.ErrorDetails.Message) {
        Write-Host ""
        Write-Host "Error Details:" -ForegroundColor Yellow
        $_.ErrorDetails.Message | ConvertFrom-Json | ConvertTo-Json -Depth 10
    }
}
