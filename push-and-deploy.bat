@echo off
setlocal EnableExtensions EnableDelayedExpansion
title OKLUT HRMS - Git Push and Deploy
color 0B

echo ========================================================
echo             OKLUT HRMS - GIT PUSH & DEPLOY               
echo ========================================================
echo.

set "SCRIPT_DIR=%~dp0"
set "REPO_DIR=%SCRIPT_DIR%HRMS_app-main"

if exist "%REPO_DIR%\.git" goto FOUND_GIT

set "REPO_DIR=%SCRIPT_DIR%"
if exist "%REPO_DIR%\.git" goto FOUND_GIT

echo [ERROR] Could not find .git repository in %SCRIPT_DIR%
pause
exit /b 1

:FOUND_GIT
cd /d "%REPO_DIR%"
echo Git Repository: %CD%
echo.

echo Checking git status...
git status
echo.

echo Staging all changes...
git add .
echo.

echo Committing changes...
git commit -m "Fix identical payslip bug, add payroll clear feature, and add employee search bar at top"
echo.

echo Pushing to GitHub (origin main)...
git push origin main

if %ERRORLEVEL% equ 0 (
    color 0A
    echo.
    echo ========================================================
    echo      SUCCESSFULLY PUSHED TO GITHUB (origin/main)!       
    echo ========================================================
    echo.
    echo GitHub Actions CI/CD has automatically started deployment:
    echo Pipeline:  https://github.com/Suryani-76/HRMS_app/actions
    echo Live Site: https://suryani-76.github.io/HRMS_app
    echo.
) else (
    color 0C
    echo.
    echo [ERROR] Git push failed. Please verify your GitHub credentials.
)

pause

