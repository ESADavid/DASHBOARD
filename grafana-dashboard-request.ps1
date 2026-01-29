# Script to make the specified GET request to Grafana dashboard API
# Replace 'your.grafana.com' with your actual Grafana instance URL

$url = "http://localhost:3000/api/org/"
$headers = @{
    "Accept" = "application/json"
    "Content-Type" = "application/json"
    "X-Grafana-Org-Id" = "2"
    "Authorization" = "Bearer eyJrIjoiT0tTcG1pUlY2RnVKZTFVaDFsNFZXdE9ZWmNrMkZYbk"
}

Write-Host "Making GET request to: $url" -ForegroundColor Green
Write-Host "Headers:" -ForegroundColor Yellow
$headers.GetEnumerator() | ForEach-Object { Write-Host "  $($_.Key): $($_.Value)" }

try {
    $response = Invoke-WebRequest -Uri $url -Method GET -Headers $headers
    Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Cyan
    Write-Host $response.Content
} catch {
    Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
    }
}
