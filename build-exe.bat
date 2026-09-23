@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"

echo ==========================================
echo          SCOUT GAME - EXE BUILDER
echo ==========================================
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Node.js is not installed or is not in PATH.
  echo Install Node.js LTS from https://nodejs.org/ and run this file again.
  pause
  exit /b 1
)

if not exist node_modules (
  echo [1/3] Installing build dependencies...
  call npm install
  if errorlevel 1 goto :failed
) else (
  echo [1/3] Dependencies already installed.
)

echo [2/3] Building Windows installer and portable EXE...
call npm run dist
if errorlevel 1 goto :failed

echo [3/3] Done!
echo.
echo Your files are in:
echo %CD%\dist
echo.
start "" "%CD%\dist"
pause
exit /b 0

:failed
echo.
echo [ERROR] EXE build failed. Read the error above and try again.
pause
exit /b 1
