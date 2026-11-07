# Launch FraudShield AI Frontend
Write-Host "Opening FraudShield AI Frontend Client in default browser..." -ForegroundColor Green
try {
    $null = Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
    Write-Host "Connected to live Spring Boot backend at http://localhost:8080" -ForegroundColor Cyan
    Start-Process "http://localhost:8080"
} catch {
    Write-Host "Backend is starting or offline. Opening local frontend client..." -ForegroundColor Yellow
    Start-Process "$PSScriptRoot\frontend\index.html"
}
