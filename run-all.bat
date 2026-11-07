@echo off
title FraudShield AI - Full-Stack Launcher
echo ========================================================
echo   FraudShield AI: Full-Stack (Backend + Frontend)
echo ========================================================

curl -s --connect-timeout 2 http://localhost:8080/ >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Backend is already running at http://localhost:8080.
    echo Opening connected frontend in browser...
    start "" "http://localhost:8080"
    goto end
)

echo Starting Spring Boot backend in a new window...
start "FraudShield AI Backend" cmd /k "cd /d "%~dp0backend" && mvnw.cmd spring-boot:run"

echo Waiting for backend to initialize on http://localhost:8080...
:waitloop
timeout /t 2 /nobreak >nul
curl -s --connect-timeout 2 http://localhost:8080/ >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Waiting for Spring Boot to be ready...
    goto waitloop
)

echo Backend is UP and READY!
echo Opening connected website at http://localhost:8080...
start "" "http://localhost:8080"

:end
exit
