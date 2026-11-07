@echo off
title FraudShield AI - Frontend Client
echo ========================================================
echo Opening FraudShield AI Frontend in your default browser
echo ========================================================
curl -s --connect-timeout 2 http://localhost:8080/ >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Connected to live backend at http://localhost:8080
    start "" "http://localhost:8080"
) else (
    echo Opening local frontend files...
    start "" "%~dp0frontend\index.html"
)
exit
