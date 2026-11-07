# Run FraudShield AI (Full-Stack Backend + Connected Frontend)
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "       FraudShield AI: Starting Full-Stack Application   " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

# Check if port 8080 is already running
$running = $false
try {
    $null = Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
    $running = $true
} catch {
    $running = $false
}

if (-not $running) {
    Write-Host "Starting Spring Boot Backend on http://localhost:8080..." -ForegroundColor Yellow
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "Set-Location '$PSScriptRoot\backend'; Write-Host 'FraudShield AI Backend Running...'; .\mvnw.cmd spring-boot:run"
    
    Write-Host "Waiting for backend service to become ready..." -ForegroundColor Yellow
    $retries = 30
    while ($retries -gt 0) {
        Start-Sleep -Seconds 2
        try {
            $test = Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
            if ($test.StatusCode -eq 200) {
                Write-Host "Backend is online and ready!" -ForegroundColor Green
                break
            }
        } catch {
            Write-Host "." -NoNewline
        }
        $retries--
    }
} else {
    Write-Host "Backend is already online and running at http://localhost:8080" -ForegroundColor Green
}

Write-Host "`nLaunching connected Frontend at http://localhost:8080..." -ForegroundColor Cyan
Start-Process "http://localhost:8080"
