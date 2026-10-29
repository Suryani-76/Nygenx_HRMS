@echo off
setlocal EnableExtensions EnableDelayedExpansion
title OKLUT HRMS Development Server
color 0A

echo ========================================================
echo               OKLUT HRMS - STARTING SERVER              
echo ========================================================
echo.

set "SCRIPT_DIR=%~dp0"
set "APP_DIR=%SCRIPT_DIR%HRMS_app-main\hrms-app"

if exist "%APP_DIR%\package.json" goto FOUND_APP

set "APP_DIR=%SCRIPT_DIR%hrms-app"
if exist "%APP_DIR%\package.json" goto FOUND_APP

set "APP_DIR=%SCRIPT_DIR%"
if exist "%APP_DIR%\package.json" goto FOUND_APP

color 0C
echo [ERROR] Could not find package.json in %APP_DIR%
pause
exit /b 1

:FOUND_APP
cd /d "%APP_DIR%"
echo Working Directory: %CD%
echo.

where node >nul 2>nul
if %ERRORLEVEL% neq 0 goto NO_NODE

echo Found Node.js:
call node -v
echo.

echo Starting Vite dev server on http://localhost:5174/ ...
start "" "http://localhost:5174/"

call npm run dev

if %ERRORLEVEL% neq 0 (
    echo.
    echo [Fallback] Starting direct Vite runner...
    call node node_modules\vite\bin\vite.js
)

pause
exit /b 0

:NO_NODE
color 0C
echo.
echo [ERROR] Node.js is not detected in your PATH.
echo If Node is installed, please run the following in your Antigravity IDE terminal:
echo   cd HRMS_app-main\hrms-app
echo   npm run dev
echo.
pause
exit /b 1
